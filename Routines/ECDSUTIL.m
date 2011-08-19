ECDSUTIL ;BIR/RHK,TTH - Event Capture Utilities ;4 May 95
 ;;2.0; EVENT CAPTURE ;**4,5,7,14,18,29**;8 May 96
 ;Routine of various utilities and common subroutines
UNIT ;Select DSS Unit
 I '$D(ECL) D ^ECL Q:'$D(ECL)
 S CNT=0 F XX=0:0 S XX=$O(^ECJ("AP",ECL,XX)) Q:'XX  S CNT=CNT+1 S ECD=XX
 I CNT<2 D  G SETVAR
 .S ECDN=$P(^ECD(ECD,0),"^") W !,"DSS Unit: ",ECDN
 .S Y=ECD_"^"_$P(^ECD(ECD,0),"^")
 .S Y(0)=^ECD(ECD,0)
 .Q
 S DIC=724,DIC(0)="AEQMZ",DIC("A")="Select DSS Unit: ",DIC("S")="I $D(^ECJ(""AP"",ECL,+Y))" D ^DIC K DIC I Y<0 K ECL Q
 S ECD=+Y,ECDN=$P(Y,U,2)
SETVAR ;Set variable from the selected DSS Unit.
 S ECD(0)=Y(0),ECS=$P(Y(0),U,2),ECMS=$P(Y(0),U,3),ECOST=$P(Y(0),U,4),ECSN=$P(^DIC(49,ECS,0),U)
 S ECPCE="U~"_$S($P(ECD(0),U,14)]"":$P(ECD(0),"^",14),1:"N")
 I $P(^ECD(ECD,0),U,11) D  I $D(ECERR) K ECL,ECD,ECS,ECMS,ECOST,ECSN Q
 .S DIC=726,DIC(0)="AEQMZ",DIC("A")="Select Category: ",DIC("S")="I $D(^ECJ(""AP"",ECL,ECD,+Y))&('$P(^EC(726,+Y,0),U,3)!($P(^EC(726,+Y,0),U,3)>DT))"
 .D ^DIC K DIC I Y<0 S ECERR=1 Q
 .S ECC=+Y,ECCN=Y(0,0)
 I '$D(ECC) S ECC=0,ECCN="None"
 Q
 ;
 ;
 ;ALB/ESD - Procedure Reason utilities
 ;
ADREAS(ECSPTR) ; Add procedure reason(s) to the EC Procedure Reason (#720.4)
 ;         file and pointers to the EC Event Code Screens/Proc Reason
 ;         Link (#720.5) file
 ;
 N DA,DIC,DLAYGO,DIE,DR,ECPRPTR,X,Y,DUOUT,DTOUT
ASK S ECSPTR=+$G(ECSPTR)
 I 'ECSPTR G ADREASQ
 S DIC="^ECR(",DIC(0)="QEALZ",DLAYGO=720.4,DIC("A")="Enter procedure reason: "
 D ^DIC
 Q:Y=-1  Q:($D(DUOUT)!$D(DTOUT))
 I +Y>0 D
 . S ECPRPTR=+Y
 . S DIE=DIC,DA=ECPRPTR,DR=".02////1" D ^DIE
 . K DA,DIC,DLAYGO,DIE,Y
 . I '$D(^ECL("AC",ECPRPTR,ECSPTR)) D
 .. S DIC="^ECL(",DIC(0)="L",DLAYGO=720.5,X=ECPRPTR,DIC("DR")=".02////"_ECSPTR
 .. K DD,DO D FILE^DICN
 G ASK
ADREASQ Q
 ;
 ;
GETSCRN(ECPPTR) ; Get EC Event Code Screens (#720.3) file internal entry number
 ;         (IEN)
 ;
 ;       Input:   ECPPTR = Event Capture Patient (#721) file IEN
 ;
 ;      Output:   EC Event Code Screens IEN if found or zero if not
 ;
 I '$G(ECPPTR) G GETSCRNQ
 N ECSIEN,ECNODE0
 S ECSIEN=0,ECNODE0=""
 ;
 ;- Get EC Patient record zero node
 S ECNODE0=$G(^ECH(+ECPPTR,0))
 I ECNODE0="" G GETSCRNQ
 ;
 ;- Get EC Screen IEN from file #720.3 "AP" xref using Loc, DSS Unit,
 ;  Category, and Procedure from EC Patient record
 S ECSIEN=+$O(^ECJ("AP",+$P(ECNODE0,U,4),+$P(ECNODE0,U,7),+$P(ECNODE0,U,8),$P(ECNODE0,U,9),0))
 I 'ECSIEN G GETSCRNQ
 ;
 ;- If 'Ask Procedure Reasons?' field = Yes and one or more procedure
 ;  reasons entered for the event code screen
 S ECSIEN=$S((+$P($G(^ECJ(ECSIEN,"PRO")),U,5))&(+$O(^ECL("AD",ECSIEN,0))):ECSIEN,1:0)
GETSCRNQ Q +$G(ECSIEN)
 ;
 ;
GETPRO() ;Get procedure from user and determine type
 ;     Input: None
 ;    Output: 1^type of procedure: X = procedure number
 ;                                 N = CPT or national number
 ;                                 A = name of procedure
 ;                                 S = procedure synonym
 ;            or -1 if unsuccessful
 ;
 ;            ECPROCED = value of Y from DIR call
 ;            ECMODS   = value of CPT modifiers separated by comman
 ;
 N ECANS,Y
 K ECMODS S ECMODS="",ECANS=-1
 S DIR(0)="FAO",DIR("A")="Enter Procedure: "
 D ^DIR
 I $D(DIRUT)!($D(DUOUT))!($D(DTOUT))!(Y="") G GETPROQ
 I $G(Y)]"" D
 . S ECANS=$S($P(Y,"-")?1.4N:"X",($L($P(Y,"-"))=5)&(($P(Y,"-")?5N)!($P(Y,"-")?1A4AN)):"N",((Y?1A.ANP)&($E(Y,1)'="&")):"A",(Y?1"&".ANP):"S",($A(Y)=32):"L",(($L(Y)>5)&(Y?1N.ANP)):"A",1:"ERR")
 . ;S ECANS=$S(Y?1.4N:"X",($L(Y)=5)&((Y?5N)!(Y?1A4AN)):"N",((Y?1A.ANP)&($E(Y,1)'="&")):"A",(Y?1"&".ANP):"S",($A(Y)=32):"L",(($L(Y)>5)&(Y?1N.ANP)):"A",1:"ERR")
 . I ECANS'="ERR" D
 .. I "X^N^"[ECANS S ECMODS=$P(Y,"-",2),Y=$P(Y,"-")
 .. S ECMODS=$TR(ECMODS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .. S ECANS=1_"^"_ECANS
 .. S ECPROCED=Y I $E(ECPROCED,1)="&" S ECPROCED=$E(ECPROCED,2,$L(ECPROCED))
 . I ECANS="ERR" S ECANS=-1
 ;
GETPROQ K DIR,DIRUT,DTOUT,DUOUT
 Q $G(ECANS)
 ;
 ;
SRCHTM(ANS) ; Lookup for procedures in ^TMP("ECPRO",$J)
 ;     Input:  Procedure type (see first output in GETPRO function above)
 ;    Output:  ECPCNT:   -1 = no (or bad) procedure type
 ;                        0 = procedure is in local ECPNAME array 
 ;                            (for A and S types)
 ;                   number = procedure number (for X and N types)
 ;
 ;             ECPNAME      = procedure number^procedure name
 ;                            (for A and S types)
 ;
 N ECNOGO,ECPNAM,ECPUNAM,I,J
 S ECPCNT=-1,ECPNAM="",J=0
 I +ANS=-1!($G(ANS)="") G SRCHTMQ
 I +ANS=1,('$D(ECPROCED)) S ANS=-1 G SRCHTMQ
 ;
 ;-- Get 2nd piece of procedure type (letter) for lookup
 S ANS=$P(ANS,"^",2)
 ;
 ;-- Convert to upper case to handle case sensitivity
 S ECPROCED=$$UPPER^VALM1(ECPROCED)
 ;
 ;-- X = procedure number
 I ANS="X",$D(^TMP("ECPRO",$J,ECPROCED)) S ECPCNT=ECPROCED G SRCHTMQ
 ;
 ;-- N = CPT or national number
 I ANS="N",(+$O(^TMP("ECPRO",$J,"N",ECPROCED,0))>0) S ECPCNT=+$O(^TMP("ECPRO",$J,"N",ECPROCED,0)) G SRCHTMQ
 ;
 ;-- If "N" and not in National # xref, chk to see if it's a proc name
 I ANS="N",(+$O(^TMP("ECPRO",$J,"N",ECPROCED,0))=0) S ANS="A"
 ;
 ;-- L = last procedure (spacebar/return functionality)
 I ANS="L",$D(^TMP("ECLKUP",$J,"LAST")) S ECPCNT=+$P($G(^TMP("ECLKUP",$J,"LAST")),"^") G SRCHTMQ
 ;
 ;-- A = name of procedure / S = procedure synonym
 I ANS="A"!(ANS="S") D
 . F  S ECPNAM=$O(^TMP("ECPRO",$J,$S(ANS="A":"B",ANS="S":"SYN"),ECPNAM)) Q:ECPNAM=""  D
 .. S ECNOGO=0
 .. S ECPUNAM=$$UPPER^VALM1(ECPNAM)
 .. F I=1:1:$L(ECPROCED) S:$E(ECPROCED,I)'=$E(ECPUNAM,I) ECNOGO=1
 .. I 'ECNOGO S J=J+1,ECPCNT=0,ECPNAME(J)=+$O(^TMP("ECPRO",$J,$S(ANS="A":"B",ANS="S":"SYN"),ECPNAM,0))_"^"_ECPNAM
 I ANS="L",'$D(^TMP("ECLKUP",$J,"LAST")) S ECPCNT=-2
SRCHTMQ Q
 ;
 ;
PRLST() ;Print list if more than one procedure matches
 ;
 N ECFL,ECRESP,ECMAX,I
 S (ECFL,ECRESP,ECMAX,I)=0
 G:'$D(ECPNAME) PRLSTQ
 F  S I=$O(ECPNAME(I)) Q:'I!(ECFL)  D
 . I '$D(ECPNAME(2)) S (ECFL,ECRESP)=1 Q
 . W !?5,I,?10,$P(ECPNAME(I),"^",2) S ECMAX=I
 G:ECFL PRLSTQ
CHOOSE S ECRESP=0
 W !!,"CHOOSE 1-"_ECMAX_": " R ECRESP:DTIME I '$T!(ECRESP["^") G PRLSTQ
 I +ECRESP<1!(+ECRESP>ECMAX) W *7,"??" G CHOOSE
PRLSTQ Q $S(ECRESP>0:+$P(ECPNAME(ECRESP),"^"),1:-1)
 ;
 ;
 ;
ERRMSG ;Invalid procedure error message
 ;
 W !!,"Enter a valid procedure or press ""^"" to exit.",!
 Q
 ;
 ;
ERRMSG2 ;Spacebar/return error message
 ;
 W !!?5,"One procedure must be entered before using spacebar/return",!?5,"to get the same procedure.",!
 Q
 ;
 ;
KILLV ;
 K ECPCNT,ECPNAME,ECPROCED,ECPROS,ECX
 Q
