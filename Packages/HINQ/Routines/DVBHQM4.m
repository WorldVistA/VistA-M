DVBHQM4 ;ISC-ALBANY/PKE-Birls abbrev name num ret ; 10 Apr 2000 10:41 AM ;
 ;;4.0;HINQ;**19,37**;03/25/92 
 G EN
LIN S CT=CT+1,A1=A_CT_",0)",@A1=T1 Q
DD ;Translate dates into displayed format MMYY.
 ;The temporary date display format will be replaced by MMCCYY once
 ;VBA sends in the centuries of the dates.
 I +$G(Y)'=0 S Y=$S($E(Y,1,2):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,1,2)),1:"")_""_$E(Y,3,4) Q
 ;;;S Y="       "
 S Y="     "
 Q
 ;
EN I '$D(DVBRECN) D KILL G KLL^DVBHQM3
 S BL="" I DVBABREV="M" D NAM D KILL G ERR^DVBHQM3
 I DVBABREV="N" D NUM D KILL G ERR^DVBHQM3
 Q
KILL K DVBSSN,DVBSN,DVBBOS,DVBRECN,DVBEOD,DVBRAD,DVBDOB,DVBDOD,DVBNAM,DVBFL,DVBPAYN,DVBCN Q
 Q
NAM S T1="   NAME                       Fld Loc   Claim #     EOD     RAD    DOB     DOD" D LIN S T1="" D LIN
 ;
 F I=1:1:DVBRECN D DAT,LIST
 Q
DAT ; Dates sent in as MMYY.
 F J="DVBEOD(I)","DVBRAD(I)","DVBDOB(I)","DVBDOD(I)" S Y=@(J) D DD S @J=Y
 Q
LIST ;Temporarily add 2 space between dates for dates displayed as MMYY.
 ;Change display back to the commented out one when VBA sends century.
 ;;;S T1=$E(DVBNAM(I),1,22)_" "_$J($E(DVBFL(I),1,15),15)_" "_DVBCN(I)_" "_DVBEOD(I)_" "_DVBRAD(I)_" "_DVBDOB(I)_" "_DVBDOD(I) D LIN S T1="" D LIN
 S T1=$E(DVBNAM(I),1,22)_" "_$J($E(DVBFL(I),1,15),15)_" "_DVBCN(I)_" "_DVBEOD(I)_"   "_DVBRAD(I)_"   "_DVBDOB(I)_"   "_DVBDOD(I) D LIN S T1="" D LIN
 Q
 ;
NUM S T1="Claim #     SS #    Service #  EOD    RAD     DOB     DOD    BOS  Folder Loc...." D LIN S T1="" D LIN
 ;
 F I=1:1:DVBRECN D DAT,LIST1
 Q
LIST1 ;Temporarily add 2 space between dates for dates displayed as MMYY.
 ;Change display back to the commented out one when VBA sends century.
 ;;;S T1=DVBCN(I)_" "_DVBSSN(I)_" "_DVBSN(I)_DVBEOD(I)_" "_DVBRAD(I)_" "_DVBDOB(I)_" "_DVBDOD(I)_" "_DVBBOS(I)_" "_$S($L(DVBFL(I))>14:$E($P(DVBFL(I)," -",1),1,14),1:DVBFL(I)) D LIN S T1="" D LIN
 S T1=DVBCN(I)_" "_DVBSSN(I)_" "_DVBSN(I)_DVBEOD(I)_"   "_DVBRAD(I)_"   "_DVBDOB(I)_"   "_DVBDOD(I)_"   "_DVBBOS(I)_" "_$S($L(DVBFL(I))>14:$E($P(DVBFL(I)," -",1),1,14),1:DVBFL(I)) D LIN S T1="" D LIN
 Q
