MCESMFDV ;WISC/DCB-Manager Options for Mark for Deletion  ;3/9/93
 ;;2.3;Medicine;;09/13/1996
LOOKUP ; Check to see if the user has proper keys.
 ;
 D MCPPROC^MCARP
 I 'MCESON W !,"Release Control is not turned on." D EXIT Q
 I '$D(^XUSEC("MCMANAGER",DUZ)) W !,"You do not have the Medicine Manager Key" D EXIT Q
 I 'MCESSEC W !,"You do not have the require key for ",MCROUT D EXIT Q
 S:XQY0["MFD" MCESMFD=1 S:XQY0["SUP" MCESSUP=1
 D @MCPRTRTN W @IOF D EXIT Q
EXIT ;
 K MCTEMP,MCESMFD,MCESSUP,MCKEY,MCROUT2,DIC,MCOUNT
 K MCESON,MCESKEY,MCROUT,MCARCODE,MCEBRIEF,MCEFULL,MCPBRIEF,MCPFULL,MCPRTRTN,MCBS,MCSUP
 Q
SUPON ;
 D MCPPROC^MCARP
 I 'MCESON W !,"Release Control is not turned on." D EXIT Q
 I '$D(^XUSEC("MCMANAGER",DUZ)) W !,"You do not have the Medicine Manager Key" D EXIT Q
 I 'MCESSEC W !,"You do not have the '"_MCESKEY_"' KEY." D EXIT Q
 W !,$S(MCSUP=1:"Superseded View (by non-manager) turned off",1:"Superseded View (by non-manager) turn on")
 S $P(^MCAR(697.2,MCARP,0),U,16)=$S(MCSUP=0:1,1:0)
 Q
