VAFCRAUD ;BHAM/DRI-ROUTINE TO CALL VAFC REMOTE AUDIT (PATIENT) ;2/22/02
 ;;5.3;Registration;**477,479**;Aug 13, 1993
 ;Reference to ^DGCN(391.91 supported by IA #2911
 ;Reference to EN1^XWB2HL7 supported by IA #3144
 ;Reference to RPCCHK^XWB2HL7 supported by IA #3144
 ;Reference to RTNDATA^XWBDRPC supported by IA #3149
ASK ;Ask For Patient
 K DIRUT
 W !!,"Patient lookup can be done by Patient Name, SSN or by ICN.",!
 S DFN="",ICN=""
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: ",D="SSN^AICN^B^BS^BS5"
 D MIX^DIC1 K DIC,D
 I Y<0 S REXIT=1 G QUIT
 S DFN=+Y
 S ICN=+$$GETICN^MPIF001(DFN) I ICN<1 W !,"There is no Integration Control Number assigned to this patient,",!,"no treating facilities to query." G ASK
 Q
ASK2 ;Ask for Date Range
 W !!,"Enter date range for data to be included in report."
 K DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DAO^:DT:EPX",DIR("A")="Beginning Date:  " D ^DIR K DIR G:$D(DIRUT) QUIT S VAFCBDT=Y
 S DIR(0)="DAO^"_VAFCBDT_":DT:EPX",DIR("A")="Ending Date:  " D ^DIR K DIR G:$D(DIRUT) QUIT S VAFCEDT=Y
 ;
 D SEND(ICN,VAFCBDT,VAFCEDT)
 ;
QUIT ;
 K Y
 Q
 ;
SEND(ICN,VAFCBDT,VAFCEDT) ;
 N TFL,X,Y,SNTDT,MPIDIR
 D GETTFL(ICN,.TFL)
 I $D(^XTMP("VAFCRAUD"_ICN,0)) S SNTDT=$$FMTE^XLFDT($P(^XTMP("VAFCRAUD"_ICN,0),"^",2)) W !,"Query last sent for this ICN on "_SNTDT,!
 I $P($G(TFL(0)),"^",1)=1 D
 . D SELTF Q:((Y="")!(Y="^"))
 . W !,"Remote patient data queries will be sent to: "
 . S CNT=0,X=0 F  S X=$O(TFARR(X)) Q:'X  S CNT=CNT+1
 . I CNT>22 D D2
 . I CNT<23 D D1
 . W ! K DIR S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to continue" D ^DIR S MPIDIR=+Y K DIR
 . I MPIDIR=1 S X=0 F  S X=$O(TFL(X)) Q:'X  D
 .. W !?3,"Sending Remote Query to: ",X,"  ",$P(TFL(X),"^")
 .. I $D(^XTMP("VAFCRAUD"_ICN,X)) K ^XTMP("VAFCRAUD"_ICN,X)
 .. D REQ(ICN,.TFL,X)
 I '$D(TFL(0)) W !!?3,"There are no remote treating facilities listed for this patient.",!?3,"No remote query will be sent."
 K ICNARR,X,Y,CNT,TFARR,TFL
 Q
SEND2 ;
 N REXIT S REXIT=0
 W !!,"This option sends a remote query to selected treating"
 W !,"facility site(s) for MPI/PD data for a patient."
 F  D  Q:REXIT=1
 . D ASK
 . I $D(Y) D SEND
 K ICN,DFN
 Q
CHKSTAT(ICN) ;check on the status for a given ICN or SSN
 N TFL,L,Y,ICNARR,STATUS,SL
 W !!,"Checking the status of remote patient data query.",!
 I '$D(^XTMP("VAFCRAUD"_ICN)) W !,"No remote query sent for this patient." Q
 D GETTFL(ICN,.TFL)
 W !!,"-> For ICN ",$P(ICN,"V",1),!
 I $D(TFL(0)) D
 . S X=0 F  S X=$O(TFL(X)) Q:'X  I '$D(^XTMP("VAFCRAUD"_ICN,X)) K TFL(X)
 D SELTF
 I '$D(TFARR) W !,"No remote query sent for this patient." Q
 Q:((Y="")!(Y="^"))
 S L=0 F  S L=$O(TFARR(L)) Q:'L  D
 . S SL=$P(TFARR(L),"^",1)
 . S STATUS=$P(TFL(SL),"^",3)
 . I STATUS["Handle" S STATUS="Error in Process"
 . E  I STATUS["New" S STATUS="Request Sent"
 . E  I STATUS["Running" S STATUS="Awaiting Response"
 . E  I STATUS["Done" S STATUS="Response Received"
 . W !?3,"  ",$P(TFL(SL),"^"),"  status: (",STATUS,")"
 I '$D(TFL(0)) W !!?3,"There are no remote treating facilities listed for this patient.",!?3,"No remote query sent for this patient."
 K ICNARR,L,SL,TFARR,TFL
 Q
CHKSTAT2 ;
 N REXIT S REXIT=0
 W !!,"This option checks the status of an existing remote patient data query."
 F  D  Q:REXIT=1
 . D ASK
 . I $D(Y) D CHKSTAT
 K ICN,DFN
 Q
DISP    ;display returned AUDIT queries
 W !!,"Display data returned from remote patient data queries."
 W !,"(Be sure HISTORY is enabled to capture data!)",!
 N TFL,L,Y,ICNARR,STATUS
 I '$D(^XTMP("VAFCRAUD"_ICN)) W !!,"No remote query sent for this patient." Q
 D GETTFL(ICN,.TFL)
 W !!,"-> For ICN ",$P(ICN,"V",1),!
 I $D(TFL(0)) D
 . S X=0 F  S X=$O(TFL(X)) Q:'X  I '$D(^XTMP("VAFCRAUD"_ICN,X)) K TFL(X)
 D SELTF
 I '$D(TFARR) W !,"No remote query sent for this patient." Q
 Q:((Y="")!(Y="^"))
 S L=0 F  S L=$O(TFARR(L)) Q:'L  D
 . S SL=$P(TFARR(L),"^",1)
 . S STATUS=$P(TFL(SL),"^",3)
 . I STATUS["Handle" S STATUS="Error in Process"
 . E  I STATUS["New" S STATUS="Request Sent"
 . E  I STATUS["Running" S STATUS="Awaiting Response"
 . E  I STATUS["Done" S STATUS="Response Received"
 . W !?3,"  ",$P(TFL(SL),"^"),"  status: (",STATUS,")"
 . D DISPLAY(ICN,$P(TFL(SL),"^",2))
 I '$D(TFL(0)) W !?3,"There are no remote treating facilities listed for this patient.",!?3,"No remote query exists for this patient."
 K ICNARR,L,SL,TFARR,TFL
 Q
DISP2 ;
 N REXIT S REXIT=0
 F  D  Q:REXIT=1
 . D ASK
 . I $D(Y) D DISP
 K ICN,DFN
 Q
DISPLAY(ICN,LOC) ;display a remote audit report
 N STATUS,RETURN,RESULT,RET,R
 I '$D(^XTMP("VAFCRAUD"_ICN,0)) W !?15," - No audit query exists for this record."
 I $D(^XTMP("VAFCRAUD"_ICN,LOC,0)) S RETURN(0)=$P(^XTMP("VAFCRAUD"_ICN,LOC,0),"^") D
 . D RPCCHK^XWB2HL7(.RESULT,RETURN(0)) I +RESULT(0)=1 D
 .. D RTNDATA^XWBDRPC(.RET,RETURN(0))
 .. I $D(RET(0)) I RET(0)<0 W !!,"No data returned due to: "_$P(RET(0),"^",2) Q
 .. I $G(RET)'="",$D(@RET) S GLO=RET F  S GLO=$Q(@GLO) Q:$QS(GLO,1)'=$J  S TXT=@GLO W !,TXT I $Y>22 S DIR(0)="E" D ^DIR K DIR W @IOF S $Y=1 ;**479
 .. S R="" F  S R=$O(RET(R)) Q:R=""  W !,RET(R) I $Y>22 S DIR(0)="E" D ^DIR K DIR W @IOF S $Y=1 ;**479
 Q
GETTFL(ICN,TFL) ;Check for existing Treating Facilities
 N LOC,HOME
 S HOME=$$SITE^VASITE()
 S TF=0 F  S TF=$O(^DGCN(391.91,"APAT",DFN,TF)) Q:'TF  D
 . S LOC=$$NNT^XUAF4(TF)
 . I $P(LOC,"^",2)'=$E($P(HOME,"^",3),1,3) D
 .. S TFL($P(LOC,"^",2))=LOC
 .. S LOC=$P(LOC,"^",2)
 .. D MONITOR(ICN,LOC,.RESULT)
 .. S $P(TFL(LOC),"^",3)=$P(RESULT(0),"^",2)
 I $O(TFL(0)) S TFL(0)=1
 K TF
 Q
SELTF ;Allow the user to select treating facilites from a list
 K TFARR,TFARR1
 S I=0 F  S I=$O(TFL(I)) Q:'I  D
 . S TFARR1($P(TFL(I),"^",1))=$P(TFL(I),"^",2)_"^"_$P(TFL(I),"^",1)
 S I="",CNT=0 F  S I=$O(TFARR1(I)) Q:I=""  D
 . S CNT=CNT+1 S TFARR(CNT)=TFARR1(I)
 I CNT=1 S Y=1 Q
 K DIR,Y
 S CNT=CNT+1,TFARR(CNT)="ALL"
 S DIR(0)="LA^1:"_CNT
 S DIR("A")="Select site(s) 1-"_(CNT-1)_" or "_CNT_" for all: "
 W !,"Select one or more of the following: "
 I CNT>22 D D2
 I CNT<23 D D1
 D ^DIR K DIR
 I Y<1 K TFARR,TFARR1,L,I,A,CNT Q
 S Y=","_Y
 I Y[(","_CNT_",") K TFARR(CNT),TFARR1,CNT,I Q
 S I=0,A="" F  S I=$O(TFARR(I)) Q:'I  I Y'[(","_I_",") S A=$P(TFARR(I),"^",1) K TFL(A) K TFARR(I)
 K L,I,A,TFARR(CNT),CNT,TFARR1
 Q
MONITOR(ICN,LOC,RESULT) ;
 N STATUS,RETURN
 I '$D(^XTMP("VAFCRAUD"_ICN,0)) S RESULT(0)="-1^Unknown" Q
 I '$D(^XTMP("VAFCRAUD"_ICN,LOC,0)) S RESULT(0)="-1^Unknown" Q
 I $D(^XTMP("VAFCRAUD"_ICN,LOC,0)) S RETURN(0)=$P(^XTMP("VAFCRAUD"_ICN,LOC,0),"^",1) D RPCCHK^XWB2HL7(.RESULT,RETURN(0))
 Q
REQ(ICN,TFL,LOC)        ;request a remote audit report
 ;LOC - STATION# OF THE INSTITUTION file entry
 N VALUE S VALUE="ICN",VALUE(VALUE)=ICN
 I +LOC>0 D EN1^XWB2HL7(.RETURN,LOC,"VAFC REMOTE AUDIT",1,.VALUE,"",VAFCBDT,VAFCEDT)
 S ^XTMP("VAFCRAUD"_ICN,0)=$$FMADD^XLFDT(DT,2)_"^"_DT_"^"_"REMOTE AUDIT QUERY"
 S ^XTMP("VAFCRAUD"_ICN,LOC,0)=RETURN(0)_"^"_$$NOW^XLFDT
 Q
SENS ;Check for patient sensitivity
 N RESULT
 D PTSEC^DGSEC4(.RESULT,DFN,0,"RPC - VAFC REMOTE AUDIT^Remote Audit Query")
 I RESULT(1)>0 D
 . I '$D(^XUSEC("DG SENSITIVITY",DUZ)) D
 . W !!,"PATIENT MARKED SENSITIVE."
 . W !,"You do not have proper security to view this record."
 Q
D1 ;
 S C1=1,I=0 F  S I=$O(TFARR(I)) Q:'I  D
 . W !,C1_".",?4,"("_$P(TFARR(I),"^",1)_") "_$P(TFARR(I),"^",2) S C1=C1+1
 K C1,I
 Q
D2 ;
 S I2=23 F I=1:1:22 D
 . W !,I_".",?4,"("_$P(TFARR(I),"^",1)_") "_$P(TFARR(I),"^",2)
 . I $D(TFARR(I2)) W ?41,I2_". ",?44,"("_$P(TFARR(I2),"^",1)_") "_$P(TFARR(I2),"^",2) S I2=I2+1
 K I,I2
 Q
