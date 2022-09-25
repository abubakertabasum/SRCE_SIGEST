/****************************************************************/
/*		Creation de la table de test			*/
/****************************************************************/
CREATE TABLE essai_clob ( 
IDTXT NUMBER(3,0), 
blabla CLOB, 
CONSTRAINT PK_essai_clob PRIMARY KEY (IDTXT) ENABLE )
ORGANIZATION INDEX;
/***********************************************************/
/*Creation de la procedure de test de manipulation de CLOB */
/***********************************************************/
 create or replace procedure sp_essai_clob (	pID in number,
					  	pTXT in  varchar2,
  						pAjout in number) as
	ptr_clob clob;  /* pointer vers un clob */
   	begin
	if pAjout=0 then /* on insert pTXT au clob */   
		/* insertion d'une nouvelle ligne */
     		/*on atache le pointer ptr_clob a un nouveau champ clob */
      		insert into essai_clob
      		values (pID, empty_clob() ) returning blabla into  ptr_clob;
      
    		/*manipulation du clob*/
      		dbms_lob.write( ptr_clob,length(pTXT), 1,pTXT);
   
  	else  /* on ajoute pTXT au clob */
  
     		/*on atache le pointer ptr_clob aU champ clob modifier*/
		/*update d'une ligne existante*/
	     	select blabla into ptr_clob 
		from essai_clob 
		where IDTXT=pID for update;
      
    		/*manipulation du clob*/
      		dbms_lob.writeappend( ptr_clob, length(pTXT), pTXT);
   
  	end if;
   end;
/****************************************************************/
/*			 READ des CLOB				*/
/****************************************************************/
 create or replace procedure SP_READ_CLOB
 as 
    m_IDTXT  		number; 
    m_blabla  		clob; 
 
    readSize CONSTANT 	integer := 50;
    txt            	varchar2(50); 
    amount  		integer := readSize; 
    len     		integer      := 1; 
    offset      	integer        := 1; 
 
    cursor  cur_essai is  select IDTXT,  
                                 blabla  
                          from essai_clob; 
BEGIN  
    open cur_essai; 
    loop 
        fetch cur_essai into m_IDTXT, m_blabla; 
        exit when cur_essai%notfound;
        offset       := 1;
        len :=   dbms_lob.getlength(m_blabla);
        while(offset  < len)    
        loop
		amount  := readSize; 
                dbms_lob.read(m_blabla,amount,offset,txt); 
                dbms_output.put_line('offset=' || To_char(offset) || ' ' || 'amount=' || To_char(amount) ); 
                offset := offset + amount;
                dbms_output.put_line('ID=' || To_char(m_IDTXT) || ' ' || txt); 
	end loop;  
    end loop; 
    close cur_essai; 
EXCEPTION  
     when others then  
       if cur_essai%isopen 
       then 
           close cur_essai; 
       end if; 
       dbms_output.put_line('Erreur ' || sqlerrm);  
END;  
 
 
/****************************************************************/
/*			 test CLOB				*/
/****************************************************************/
exec sp_essai_clob(0,'essai de text ',0);
exec sp_essai_clob(1,'essai de text 1 ',0);
exec sp_essai_clob(1,'re1-essai de text 1 ',1);
exec sp_essai_clob(1,'re2-essai de text 1 ',1);
exec sp_essai_clob(1,'re3-essai de text 1 ',1);
exec sp_essai_clob(1,'re4-essai de text 1 ',1);
exec sp_essai_clob(1,'re5-essai de text 1 ',1);
exec sp_essai_clob(1,'re6-essai de text 1 ',1);
exec sp_essai_clob(1,'re7-essai de text 1 ',1);
exec sp_essai_clob(1,'re8-essai de text 1 ',1);
exec SP_READ_CLOB;
SELECT * FROM essai_clob;
