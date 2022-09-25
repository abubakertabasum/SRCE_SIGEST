DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       %YourObjectName%
   PURPOSE:    To perform work as each row is inserted or updated.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        %DATE%      %USERNAME%       1. Created this trigger.

   PARAMETERS:
   INPUT:
   OUTPUT:
   RETURNED VALUE:
   CALLED BY:
   CALLS:
   EXAMPLE USE:
   ASSUMPTIONS:
   LIMITATIONS:
   ALGORITHM:
   NOTES:

   Here is the complete list of available Auto Replace Keywords:
      Object Name:     %YourObjectName% or *YourObjectName*
      Sysdate:         %SYSDATE%
      Date/Time:       %DATETIME%
      Date:            %DATE%
      Time:            %TIME%
      Username:        %USERNAME% (set in TOAD Options, Procedure Editor)
******************************************************************************/
BEGIN
   tmpVar := 0;

   Select MySeq.NextVal into tmpVar from dual;
   :NEW.SequenceColumn := tmpVar;
   :NEW.CreatedDate := Sysdate;
   :NEW.CreatedUser := User;

   EXCEPTION
     WHEN OTHERS THEN
       Null;
END %YourObjectName%;



