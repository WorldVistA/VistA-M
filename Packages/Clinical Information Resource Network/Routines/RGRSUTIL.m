RGRSUTIL ;ALB/RJS-MPI/PD UTILITIES ;03/12/96
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**1,3,19,45,57**;30 Apr 99;Build 2
EXCEPT ;Members of the RG CIRN DEMOGRAPHIC ISSUES Mail Group are
 ;notified upon login if there are unresolved Primary View
 ;Reject exceptions for review in the MPI/PD Exception
 ;Handler ;**57 MPIC_1893 Only exception type 234 remains
 ;
 ;Is user a member of this mail group?
 S RGCDI=$$FIND1^DIC(3.8,,,"RG CIRN DEMOGRAPHIC ISSUES")
 I RGCDI="" G END
 S XMDUZ=DUZ,Y=RGCDI D CHK^XMA21 I '$T G END
 ;User is a member.
 I $O(^RGHL7(991.1,"ASTAT","0",234,0)) D
 .D SET^XUS1A("!  <<------------------------------------------------------------------------>>")
 .D SET^XUS1A("!  << You have Primary View Reject exceptions that need to be reviewed using >>")
 .D SET^XUS1A("!  << the MPI/PD Exception Handling Option on the Message Exception Menu.    >>")
 .D SET^XUS1A("!  <<------------------------------------------------------------------------>>")
END K RGCDI,XMDUZ,Y
 Q
 ;
SEG(SEGMENT,PIECE,CODE) ;Return segment from RGDC array and kill node
 N RGNODE,RGDATA,RGDONE,RGC K RGDONE
 I '$D(RGC) S RGC=$E(HL("ECH"))
 S RGNODE=0
 F  S RGNODE=$O(RGDC(RGNODE)) Q:RGNODE=""!($D(RGDONE))  D
 .S RGDATA=RGDC(RGNODE)
 .I ($P(RGDATA,HL("FS"),1)=SEGMENT)&($P($P(RGDATA,HL("FS"),PIECE),RGC,1)=CODE) S RGDONE=1 K RGDC(RGNODE)
 Q:$D(RGDONE) $G(RGDATA)
 Q ""
SEG1(SEGMENT,PIECE,CODE) ;Return segment from RGDC array 
 N RGNODE,RGDATA,RGDONE,RGC K RGDONE
 I '$D(RGC) S RGC=$E(HL("ECH"))
 S RGNODE=0
 F  S RGNODE=$O(RGDC(RGNODE)) Q:RGNODE=""!($D(RGDONE))  D
 .S RGDATA=RGDC(RGNODE)
 .I ($P(RGDATA,HL("FS"),1)=SEGMENT)&($P($P(RGDATA,HL("FS"),PIECE),RGC,1)=CODE) S RGDONE=1
 Q:$D(RGDONE) $G(RGDATA)
 Q ""
ERROR(CODE) ;**THIS ENTRY POINT IS NO LONGER USED**
 Q ""
INITIZE ;Initialize RGDC array with incoming message
 N I,J,X
 F I=1:1 X HLNEXT Q:HLQUIT'>0  S RGDC(I)=HLNODE,J=0  F  S J=$O(HLNODE(J)) Q:'J  S RGDC(I,J)=HLNODE(J)
 Q
SSNDFN(SSN) ;Input ssn output DFN
 N DFN
 Q:$G(SSN)="" -1
 S DFN=$O(^DPT("SSN",+SSN,0))
 Q:$L(DFN) DFN
 S DFN=$O(^DPT("SSN",SSN,0))
 Q:$L(DFN) DFN
 Q -1
 ;
LINE() ; Return a dashed line.       
 Q $TR($J("",80)," ","-")
 ;
PAUSE() ; Pause for CRT output.
 ;  Input:   IOST, IOSL
 ;  Output:  0  --  Continue to display output
 ;           1  --  Quit
 Q:$E(IOST,1,2)'["C-" 0
 N DIR,DIRUT,DTOUT,DUOUT,RGJ
 F RGJ=$Y:1:(IOSL-4) W !
 S DIR(0)="E" D ^DIR
 Q $D(DIRUT)!($D(DUOUT))
 ;
DIAG(X) ; Return a string for diagnoses.
 ;  Input:   X  -  Code for type of diagnosis (Primary, etc.)
 ;  Output:  Descriptive string, i.e., "Primary", etc.
 Q $S($G(X)="":"Unknown",X="A":"Additional",X="P":"Primary",X="S":"Secondary",X="T":"Tertiary",1:"Unknown")
 ;
ORD(X) ; Return a string for orders.
 ;  Input:   X  -  Code for type of order (Lab, etc.)
 ;  Output:  Descriptive string, i.e., "Lab", etc.
 Q $S($G(X)="":"Unknown",X="L":"Lab",X="R":"Radiology",1:"Unknown")
 ;
UPDTFLD(FILE,FLD,ANS1,ANS2) ; Returns the correct field answer
 ;DLR - Added to prevent the overwriting the last four in ZIP with null
 ; input:  FILE  - file number (ex. 2 PATIENT)
 ;         FLD  -  field number (ex. .1112 ZIP+4)
 ;         ANS1 -  existing field value
 ;         ANS2 -  incoming value
 I (FILE=2)&(FLD=.1112) I $E(ANS1,1,5)=$E(ANS2,1,5),($L(ANS2)=5) Q ANS1
 Q ANS2
 ;
SSNINT(SSN) ;
 Q:$G(SSN)="" ""
 Q $TRANSLATE(SSN,"-","")
 ;
ACTION ;Entry action for Primary View Reject exceptions
 I $O(^RGHL7(991.1,"ASTAT","0",234,0)) D
 .W !!,"  <<------------------------------------------------------------------------>>"
 .W !,"  << You have Primary View Reject exceptions that need to be reviewed using >>"
 .W !,"  << the MPI/PD Exception Handling Option on the Message Exception Menu.    >>"
 .W !,"  <<------------------------------------------------------------------------>>"
 Q
 ;
