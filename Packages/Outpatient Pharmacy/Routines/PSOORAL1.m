PSOORAL1 ;BHAM ISC/SAB - Build Listman activity logs ; 12/4/07 12:25pm
 ;;7.0;OUTPATIENT PHARMACY;**71,156,148,247,240,287,354,367,408,482,508**;DEC 1997;Build 295
 N RX0,VALMCNT K DIR,DTOUT,DUOUT,DIRUT,^TMP("PSOAL",$J) S DA=$P(PSOLST(ORN),"^",2),RX0=^PSRX(DA,0),J=DA,RX2=$G(^(2)),R3=$G(^(3)),CMOP=$O(^PSRX(DA,4,0))
 S IEN=0,DIR(0)="LO^1:"_$S(CMOP:10,1:9),DIR("A",1)=" ",DIR("A",2)="Select Activity Log by  number",DIR("A",3)="1.  Refill    2.  Partial     3.  Activity   4.  Labels      5.  Copay"
 S DIR("A")=$S(CMOP:"6.  ECME      7.  SPMP        8.  eRx Log    9.  CMOP Events 10.  All Logs    ",1:"6.  ECME      7.  SPMP        8.  eRx Log    9.  All Logs")
 S DIR("B")=$S(CMOP:10,1:9) D ^DIR S PSOELSE=+Y I +Y S Y=$S(CMOP&(Y[10):"1,2,3,4,5,6,7,8,9",'CMOP&(Y[9):"1,2,3,4,5,6,7,8",1:Y) S ACT=Y D FULL^VALM1 D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Rx #: "_$P(RX0,"^")_"   Original Fill Released: " I $P(RX2,"^",13) S DTT=$P(RX2,"^",13) D DAT S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_DAT K DAT,DTT
 .I $P(RX2,"^",15) S DTT=$P(RX2,"^",15) D DAT S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"(Returned to Stock "_DAT_")" K DAT,DTT
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Routing: "_$S($P(RX0,"^",11)="W":"Window",1:"Mail")_$S($P($G(^PSRX(DA,"OR1")),"^",5):"      Finished by: "_$P(^VA(200,$P(^PSRX(DA,"OR1"),"^",5),0),"^"),1:"")
 .D:$G(^PSRX(DA,"H"))]""&($P(PSOLST(ORN),"^",3)="HOLD") HLD^PSOORAL2
 .F LOG=1:1:$L(ACT,",") Q:$P(ACT,",",LOG)']""  S LBL=$P(ACT,",",LOG) D @$S(LBL=1:"RF^PSOORAL2",LBL=2:"PAR^PSOORAL2",LBL=3:"ACT",LBL=5:"COPAY",LBL=6:"ECME",LBL=7:"SPMP",LBL=8:"ERX",LBL=9:"^PSORXVW2",1:"LBL")
 I 'PSOELSE S VALMBCK="" K PSOELSE Q 
 K ST0,RFL,RFLL,RFL1,II,J,N,PHYS,L1,DIRUT,PSDIV,PSEXDT,MED,M1,FFX,DTT,DAT,R3,RTN,SIG,STA,P1,PL,P0,Z0,Z1,EXDT,IFN,DIR,DUOUT,DTOUT,PSOELSE
 K LBL,I,RFDATE,%H,%I,RN,RFT
 S PSOAL=IEN K IEN,ACT,LBL,LOG D EN^PSOORAL S VALMBCK="R"
 Q
ACT ;activity log
 N CNT
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Activity Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date/Time            Reason         Rx Ref         Initiator Of Activity",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"A",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO Activity to report" Q
 S CNT=0
 F N=0:0 S N=$O(^PSRX(DA,"A",N)) Q:'N  S P1=^(N,0) D
 .I $P(P1,"^",2)="M" Q
 .S DAT=$$FMTE^XLFDT($P(P1,"^"),2)_"             "
 .S IEN=IEN+1,CNT=CNT+1,^TMP("PSOAL",$J,IEN,0)=CNT_"   "_$E(DAT,1,21),$P(RN," ",15)=" ",REA=$P(P1,"^",2)
 .S REA=$F("HUCELPRWSIVDABXGKNO",REA)-1
 .I REA D
 ..S STA=$P("HOLD^UNHOLD^DISCONTINUED^EDIT^RENEWED^PARTIAL^REINSTATE^REPRINT^SUSPENSE^RETURNED^INTERVENTION^DELETED^DRUG INTERACTION^PROCESSED^X-INTERFACE^PATIENT INSTR.^PKI/DEA^DISP COMPLETED^IERX^","^",REA)
 ..S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA_$E(RN,$L(STA)+1,15)
 .E  S $P(STA," ",15)=" ",^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA
 .K STA,RN S $P(RN," ",15)=" ",RF=+$P(P1,"^",4)
 .S RFT=$S(RF>0&(RF<6):"REFILL "_RF,RF=6:"PARTIAL",RF>6:"REFILL "_(RF-1),1:"ORIGINAL")
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$E(RN,$L(RFT)+1,15)_$E($S($D(^VA(200,+$P(P1,"^",3),0)):$P(^(0),"^"),1:$P(P1,"^",3)),1,24)
 .;S:$P(P1,"^",5)]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Comments: "_$P(P1,"^",5)
 .I $P(P1,"^",5)]"" N PSOACBRK,PSOACBRV D
 ..S PSOACBRV=$P(P1,"^",5)
 ..;PSO*7*240 Use fileman for parsing
 ..K ^UTILITY($J,"W") S X="Comments: "_PSOACBRV,(DIWR,DIWL)=1,DIWF="C80" D ^DIWP F I=1:1:^UTILITY($J,"W",1) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$G(^UTILITY($J,"W",1,I,0))
 .I $P($G(^PSRX(DA,"A",N,1)),"^")]"" S IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",5)=$P($G(^PSRX(DA,"A",N,1)),"^") I $P($G(^PSRX(DA,"A",N,1)),"^",2)]"" S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_":"_$P($G(^PSRX(DA,"A",N,1)),"^",2)
 .I $O(^PSRX(DA,"A",N,2,0)) F I=0:0 S I=$O(^PSRX(DA,"A",N,2,I)) Q:'I  S MIG=^PSRX(DA,"A",N,2,I,0) D
 ..S:MIG["Mail Tracking Info.: " IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",9)=" "
 ..F SG=1:1:$L(MIG) S:$L(^TMP("PSOAL",$J,IEN,0)_" "_$P(MIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0)," ",9)=" " S:$P(MIG," ",SG)'="" ^TMP("PSOAL",$J,IEN,0)=$G(^TMP("PSOAL",$J,IEN,0))_" "_$P(MIG," ",SG)
 K MIG,SG,I,^UTILITY($J,"W"),DIWF,DIWL,DIWR
 Q
LBL ;label log
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Label Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date        Rx Ref                    Printed By",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"L",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There are NO Labels printed." Q
 F L1=0:0 S L1=$O(^PSRX(DA,"L",L1)) Q:'L1  S LBL=^PSRX(DA,"L",L1,0),DTT=$P(^(0),"^") D DAT D
 . S $P(RN," ",26)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=L1_"   "_DAT_"    ",RFT=$S($P(LBL,"^",2):"REFILL "_$P(LBL,"^",2),1:"ORIGINAL"),RFT=RFT_$E(RN,$L(RFT)+1,26)
 . S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$P($G(^VA(200,$P(LBL,"^",4),0)),"^"),IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Comments: "_$P(LBL,"^",3)
 . N FDAMGDOC S FDAMGDOC=$G(^PSRX(DA,"L",L1,"FDA"))
 . I FDAMGDOC'="" D
 . . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="FDA Med Guide: "_$E(FDAMGDOC,1,61)
 . . I $L(FDAMGDOC)>61 D
 . . . F  Q:$E(FDAMGDOC,62,999)=""  D
 . . . . S FDAMGDOC=$E(FDAMGDOC,62,999),IEN=IEN+1
 . . . . S ^TMP("PSOAL",$J,IEN,0)=$E(FDAMGDOC,1,61)
 Q
 ;
COPAY ;Copay activity log
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Copay Activity Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date        Reason               Rx Ref         Initiator Of Activity",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"COPAY",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO Copay activity to report" Q
 F N=0:0 S N=$O(^PSRX(DA,"COPAY",N)) Q:'N  S P1=^(N,0),DTT=P1\1 D DAT D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=N_"   "_DAT_"    ",$P(RN," ",21)=" ",REA=$P(P1,"^",2),REA=$F("ARICE",REA)-1
 .I REA D
 ..S STA=$P("ANNUAL CAP REACHED^COPAY RESET^IB-INITIATED COPAY^REMOVE COPAY CHARGE^RX EDITED^","^",REA)
 ..S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA_$E(RN,$L(STA)+1,21)
 .E  S $P(STA," ",21)=" ",^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA
 .K STA,RN S $P(RN," ",15)=" ",RF=+$P(P1,"^",4)
 .S RFT=$S(RF>0:"REFILL "_RF,1:"ORIGINAL")
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$E(RN,$L(RFT)+1,15)_$S($D(^VA(200,+$P(P1,"^",3),0)):$P(^(0),"^"),1:$P(P1,"^",3))
 .S:$P(P1,"^",5)]""!($P(P1,"^",6)]"")!($P(P1,"^",7)]"") IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Comment: "_$P(P1,"^",5)
 .I $P(P1,"^",6)]"" S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"  Old value="_$P(P1,"^",6)_"   New value="_$P(P1,"^",7)
 Q
 ;
ECME ; ECME activity log
 ;
 N DIWF,DIWL,DIWR,I,II,III,LINE,PSOAR,PSOCNT,PSOCNT1,PSOCOMMENT
 N PSODATA,PSODATE,PSODATE1,PSOFIELDS,PSOFILE,PSOIENS,PSOLINE
 N PSOREFILL,PSOREFILL1,PSOUSER,PSOUSER1
 ;
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" "
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="ECME Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date/Time           Rx Ref          Initiator Of Activity"
 S IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 ;
 ; The comments from ACTIVITY LOG (#52.3) and REJECT INFO (#52.25)
 ; will be compiled in array PSOAR. This array will allow comments
 ; from each sub-file to be sorted in ascending order by date.
 ; A counter (PSOCNT) will be used to accommodate multiple 
 ; comments with the exact same date/time.
 ;
 ; PSOAR array definition:
 ;
 ;  PSOAR(PSODATE)=PSOCNT
 ;  PSOAR(PSODATE,PSOCNT)=PSODATE^PSOUSER1^PSOREFILL1^PSOCOMMENT
 ;  PSOAR(PSODATE,PSOCNT,PSOCNT1)=Additional Comments (if any)
 ;
 ;   PSODATE ---- Date/time of comment - internal format
 ;   PSOCNT ----- Counter of comments, by date
 ;   PSOCNT1 ---- Counter of additional comments (if any)
 ;   PSOUSER1 --- User who entered comment - external format
 ;   PSOREFILL1 - Refill number - external format
 ;   PSOCOMMENT - Comment
 ;
 ; Kill PSOAR to initialize array
 ;
 K PSOAR
 ;
 ; Loop through ACTIVITY LOG (file #52.3) searching for ECME Entries.
 ; ECME Entries are defined as REASON="M".
 ;
 ; ACTIVITY LOG Fields:
 ;  .01 = Activity Log (Date)
 ;  .02 = Reason
 ;  .03 = Initiator of Activity (User)
 ;  .04 = RX Reference (Refill #)
 ;  .05 = Comment
 ;
 ; The above fields will be stored in array PSODATA via a call to ^DIQ.
 ; 
 S I=0
 F  S I=$O(^PSRX(DA,"A",I)) Q:'I  D
 . ;
 . S PSOCNT=0
 . S PSOFILE=52.3
 . S PSOIENS=I_","_DA_","
 . S PSOFIELDS=".01;.02;.03;.04;.05"
 . K PSODATA
 . ;
 . D GETS^DIQ(PSOFILE,I_","_DA,PSOFIELDS,"IE","PSODATA")
 . ;
 . ; If reason is not M (ECME), do not include comment.
 . ;
 . I $G(PSODATA(PSOFILE,PSOIENS,.02,"I"))'="M" Q
 . ;
 . S PSODATE=$G(PSODATA(PSOFILE,PSOIENS,.01,"I"))
 . S PSOUSER1=$G(PSODATA(PSOFILE,PSOIENS,.03,"E"))
 . S PSOREFILL1=$G(PSODATA(PSOFILE,PSOIENS,.04,"E"))
 . S PSOCOMMENT=$G(PSODATA(PSOFILE,PSOIENS,.05,"I"))
 . ;
 . S PSOCNT=$G(PSOAR(PSODATE))+1
 . S PSOAR(PSODATE)=PSOCNT
 . S PSOAR(PSODATE,PSOCNT)=$$FMTE^XLFDT(PSODATE,2)_U_PSOUSER1_U_PSOREFILL1_U_PSOCOMMENT
 . ;
 . ; Node 2 of the ACTIVITY LOG contains any additional comments.
 . ; Loop through OTHER COMMENTS sub-file (file #52.34) to add to PSOAR 
 . ; for reporting.
 . ;
 . I $D(^PSRX(DA,"A",I,2)) D
 . . S PSOCNT1=0
 . . S II=0
 . . F  S II=$O(^PSRX(DA,"A",I,2,II)) Q:'II  D
 . . . S PSOCNT1=PSOCNT1+1
 . . . S PSOAR(PSODATE,PSOCNT,PSOCNT1)=$$GET1^DIQ(52.34,II_","_I_","_DA,.01)
 ;
 ; Loop through REJECT INFO Comments (File #52.2551) searching for
 ; User Created entries.
 ; User Created entries are defined as User'="POSTMASTER"
 ;
 ; REJECT INFO Comments Fields:
 ;  .01  = Date/Time
 ;  1    = User
 ;  2    = Comments
 ;
 ; The above fields will be stored in array PSODATA via a call to ^DIQ.
 ;
 S I=0 F  S I=$O(^PSRX(DA,"REJ",I)) Q:'I  S PSODATE=0 F  S PSODATE=$O(^PSRX(DA,"REJ",I,"COM","B",PSODATE)) Q:'PSODATE  D
 . S III=0 F  S III=$O(^PSRX(DA,"REJ",I,"COM","B",PSODATE,III)) Q:'III  D 
 . . S REC=$G(^PSRX(DA,"REJ",I,"COM",III,0))
 . . S PSOUSER=$P(REC,U,2),PSOUSER1=$P($G(^VA(200,PSOUSER,0)),U,1)
 . . S PSOCOMMENT=$P(REC,U,3)
 . . ;
 . . S PSOREFILL=$$GET1^DIQ(52.25,I_","_DA,5)
 . . I PSOREFILL=0 S PSOREFILL1="ORIGINAL"
 . . E  S PSOREFILL1="REFILL #"_PSOREFILL
 . . ;
 . . S PSOCNT=$G(PSOAR(PSODATE))+1
 . . S PSOAR(PSODATE)=PSOCNT
 . . S PSOAR(PSODATE,PSOCNT)=$$FMTE^XLFDT(PSODATE,2)_U_PSOUSER1_U_PSOREFILL1_U_PSOCOMMENT
 ;
 ; If PSOAR array contains no data, there is No ECME Activity to report. 
 ;
 I '$D(PSOAR) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO ECME Activity to report" Q
 ;
 ; Loop through PSOAR array and assign data to ^TMP array for reporting.
 ; 
 ; PSOLINE = ECME Log Entry line number.
 ;
 S (PSODATE1,PSOREFILL,PSOUSER)=""
 S PSODATE="" F  S PSODATE=$O(PSOAR(PSODATE)) Q:PSODATE=""  D
 . S PSOCNT="" F  S PSOCNT=$O(PSOAR(PSODATE,PSOCNT)) Q:PSOCNT=""  D
 . . S PSODATA=$G(PSOAR(PSODATE,PSOCNT))
 . . ;
 . . S IEN=IEN+1
 . . I '$D(PSOLINE) S PSOLINE=0
 . . S PSOLINE=PSOLINE+1
 . . S PSODATE1=$P(PSODATA,U)
 . . S PSOUSER=$P(PSODATA,U,2)
 . . S PSOREFILL=$P(PSODATA,U,3)
 . . S LINE=PSOLINE
 . . S $E(LINE,5)=PSODATE1
 . . S $E(LINE,25)=PSOREFILL
 . . S $E(LINE,41)=PSOUSER
 . . S ^TMP("PSOAL",$J,IEN,0)=LINE
 . . ;
 . . ; D ^DIWP formats comments into ^UTILITY($J,"W")
 . . ;
 . . S PSOCOMMENT=$P(PSODATA,"^",4)
 . . ;
 . . K ^UTILITY($J,"W")
 . . ;
 . . S X="Comments: "_PSOCOMMENT
 . . S (DIWR,DIWL)=1,DIWF="C80"
 . . D ^DIWP
 . . ;
 . . ; Additional comments (if any)
 . . ;
 . . S PSOCNT1=""
 . . F  S PSOCNT1=$O(PSOAR(PSODATE,PSOCNT,PSOCNT1)) Q:PSOCNT1=""  D
 . . . S X=PSOAR(PSODATE,PSOCNT,PSOCNT1)
 . . . S DIWF="C80I10"
 . . . D ^DIWP
 . . ;
 . . ; Loop through ^UTILITY($J,"W"), adding comments to ^TMP
 . . ;
 . . F I=1:1:^UTILITY($J,"W",1) D 
 . . . S IEN=IEN+1
 . . . S ^TMP("PSOAL",$J,IEN,0)=$G(^UTILITY($J,"W",1,I,0))
 ;
 D DISPREJ
 ;
 K ^UTILITY($J,"W"),DIWR,DIWF,DIWL
 Q
 ;
SPMP ; SPMP (State Prescription Monitoring Program) Log
 N FILL,BAT,LOG,BAT0,LOG0
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1
 S ^TMP("PSOAL",$J,IEN,0)="SPMP (State Prescription Monitoring Program) Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Date/Time       Fill Type   Exp. Type Bat#  Filename"
 S IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",80)="="
 I '$D(^PS(58.42,"ARX",DA)) D  Q
 . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO Export Log for this prescription."
 S FILL=""
 F  S FILL=$O(^PS(58.42,"ARX",DA,FILL)) Q:FILL=""  D
 . S BAT=0 F  S BAT=$O(^PS(58.42,"ARX",DA,FILL,BAT)) Q:'BAT  D
 . . S LOG=0 F  S LOG=$O(^PS(58.42,"ARX",DA,FILL,BAT,LOG)) Q:'LOG  D
 . . . S BAT0=$G(^PS(58.42,BAT,0)),LOG0=$G(^PS(58.42,BAT,"RX",LOG,0))
 . . . I '$P(BAT0,"^",10) Q
 . . . S IEN=IEN+1,LINE=$$FMTE^XLFDT($P(BAT0,"^",10),2),$E(LINE,17)=$J($P(LOG0,"^",2),4)
 . . . S $E(LINE,22)=$$GET1^DIQ(58.42001,LOG_","_BAT,2),$E(LINE,29)=$$GET1^DIQ(58.42,BAT,2)
 . . . S $E(LINE,39)=BAT,$E(LINE,45)=$E($$GET1^DIQ(58.42,BAT,6),1,35)
 . . . S ^TMP("PSOAL",$J,IEN,0)=LINE
 Q
 ;
DISPREJ  ;
 N LN,SEQ,REJ,PRI,VAR,X,X1,X2,I,RFT
 I '$D(^PSRX(DA,"REJ")) Q
 S PRI="PSOAL",$P(LN,"=",80)="",SEQ=0
 S IEN=$G(IEN)+1,^TMP(PRI,$J,IEN,0)=" "
 S IEN=IEN+1,^TMP(PRI,$J,IEN,0)="ECME REJECT Log:"
 S IEN=IEN+1,^TMP(PRI,$J,IEN,0)="#  Date/Time Rcvd    Rx Ref    Reject Type     STATUS     Date/Time Resolved"
 S IEN=IEN+1,^TMP(PRI,$J,IEN,0)=LN
 F REJ=0:0 S REJ=$O(^PSRX(DA,"REJ",REJ)) Q:'REJ  D
 . S VAR=$G(^PSRX(DA,"REJ",REJ,0))
 . S RFT=+$P(VAR,"^",4)
 . S SEQ=SEQ+1,X=SEQ,$E(X,4)=$$FMTE^XLFDT($P(VAR,"^",2),2),$E(X,22)=$S(RFT:"REFILL "_RFT,1:"ORIGINAL")
 . S $E(X,32)=$S(+VAR=79:"REFILL TOO SOON",+VAR=88:"DUR",1:$E($$EXP^PSOREJP1($P(VAR,"^",1)),1,15))  ;can't + default because values can be 07, 08, etc.
 . S $E(X,48)=$S($P(VAR,"^",5):"RESOLVED",1:"UNRESOLVED")
 . S:$P(VAR,"^",6) $E(X,59)=$$FMTE^XLFDT($P(VAR,"^",6),2)
 . S IEN=IEN+1,^TMP(PRI,$J,IEN,0)=X
 . I $P(VAR,"^",5) D
 . . S IEN=IEN+1,X=$$GET1^DIQ(52.25,REJ_","_DA,12)
 . . S X1=$$GET1^DIQ(52.25,REJ_","_DA,13) S:X1'="" X=X1_" ("_X_")"
 . . F I=1:1 Q:X=""  D
 . . . S ^TMP(PRI,$J,IEN,0)=$S(I=1:"Comments: ",1:"          ")_$E(X,1,69)
 . . . S X=$E(X,70,999) S:X'="" IEN=IEN+1
 Q
 ;
ERX ; eRx Log
 N CNT,ARR,G,STR,X,I,TMP
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" "
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="eRx Activity Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date        Reason         Rx Ref         Initiator Of Activity"
 S IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",80)="="
 S IEN=IEN+1
 I '$O(^PSRX(DA,"A",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There are no eRx activity logs." Q
 S CNT=0
 D GETS^DIQ(52,DA_",","**","IE","ARR")
 M TMP=ARR(52.3) K ARR
 S N="",G=$NA(TMP) F  S N=$O(@G@(N)) Q:N=""  D
 . I @G@(N,.02,"I")="O" D
 . . S CNT=CNT+1
 . . S P1=@G@(N,.01,"I"),DTT=P1\1 D DAT
 . . S STR=CNT,$E(STR,5)=DAT,$E(STR,17)=@G@(N,.02,"E"),$E(STR,32)=@G@(N,.04,"E"),$E(STR,47)=@G@(N,.03,"E"),^TMP("PSOAL",$J,IEN,0)=STR,IEN=IEN+1
 . . K ^UTILITY($J,"W") S X="Comments: "_@G@(N,.05,"E"),(DIWR,DIWL)=1,DIWF="C80" D ^DIWP F I=1:1:^UTILITY($J,"W",1) S ^TMP("PSOAL",$J,IEN,0)=$G(^UTILITY($J,"W",1,I,0)),IEN=IEN+1
 . . ;S ^TMP("PSOAL",$J,IEN,0)="Comments: "_@G@(N,.05,"E"),IEN=IEN+1
 K ^UTILITY($J,"W"),DIWF,DIWL,DIWR
 Q
 ;
DAT S DAT="",DTT=DTT\1 Q:DTT'?7N  S DAT=$E(DTT,4,5)_"/"_$E(DTT,6,7)_"/"_$E(DTT,2,3)
 Q
