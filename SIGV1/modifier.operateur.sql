ALTER TABLE SGC_OPERATEUR 
DROP (OP_MAJ, OP_VALIDE, OP_CREATE, OP_DEVALIDE, OP_NIVEAU_RESPONSABILITE)
CASCADE CONSTRAINTS;

ALTER TABLE SGC_OPERATEUR 
ADD (OP_ACTIVE VARCHAR2(1) DEFAULT 'O' NOT NULL) ;

ALTER TABLE SGC_ROLE_OPERATEUR 
ADD (	FG_DROIT1 VARCHAR2(1) DEFAULT 'O' NOT NULL,
	FG_DROIT2 VARCHAR2(1) DEFAULT 'N' NOT NULL,
	FG_DROIT3 VARCHAR2(1) DEFAULT 'N' NOT NULL,
	FG_DROIT4 VARCHAR2(1) DEFAULT 'N' NOT NULL,
	FG_DROIT5 VARCHAR2(1) DEFAULT 'N' NOT NULL) ;


create or replace function sgf_droit_operateur (v_user varchar2,
						v_role varchar2,
						v_fgdroit number default 1
						)
return char
is
    v_droit varchar2(1):='N';
    stmt  varchar2(2048);
begin

    if v_fgdroit not between 1 and 5
      then return 'N';
    else
        stmt:='SELECT fg_droit'||v_fgdroit|| ' FROM SGC_ROLE_OPERATEUR '||
              'WHERE upper(username)='''||upper(v_user)||''' and upper(granted_role)='''||upper(v_role)||'''';
        EXECUTE IMMEDIATE stmt INTO v_droit;
        return(v_droit);
    end if;

    exception when no_data_found then
      if user='MGSIG'
         then return 'O';
      end if;

    return('N');

end sgf_droit_operateur;
/

create or replace function sgf_code_actif (v_cduser varchar2)
return char
is
  cursor cduser_ctrl is  select op_active
                  from sgc_operateur
                  where ltrim(rtrim(upper(op_code)))=ltrim(rtrim(upper(v_cduser)));
  trouve char(1):='N';
begin
  open cduser_ctrl; 
  fetch cduser_ctrl into trouve;
  close cduser_ctrl;
  return(trouve);
end function sgf_code_actif;
/

CREATE  PUBLIC SYNONYM SGF_DROIT_OPERATEUR FOR SGF_DROIT_OPERATEUR;
CREATE  PUBLIC SYNONYM SGF_CODE_ACTIF FOR SGF_CODE_ACTIF;                

GRANT	EXECUTE ON SGF_SGF_DROIT_OPERATEUR  TO PUBLIC; 
GRANT	EXECUTE ON SGF_SGF_CODE_ACTIF  TO SIG_ADMIN;
