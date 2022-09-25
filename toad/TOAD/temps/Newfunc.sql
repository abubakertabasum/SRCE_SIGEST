tmpVar NUMBER;
/******************************************************************************
   NAME:       %YourObjectName%
   PURPOSE:    To calculate the desired information.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        %SYSDATE%   %USERNAME%       1. Created this function.

   PARAMETERS:
   INPUT:
   OUTPUT:
   RETURNED VALUE:  NUMBER
   CALLED BY:
   CALLS:
   EXAMPLE USE:     NUMBER := %YourObjectName%();
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

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       Null;
     WHEN OTHERS THEN
       Null;

   RETURN tmpVar;
END %YourObjectName%;



