GMPLHS ; SLC/MKB/KER - Extract Prob List Health Summary ; 04/15/2002
 ;;2.0;Problem List;**22,26,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA  3106  ^DIC(49
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10015  EN^DIQ1
 ;                    
GETLIST(GMPDFN,STATUS) ; Define List 
 N GMPLIST,GMPLVIEW,GMPARAM,GMPTOTAL K ^TMP("GMPLHS",$J) Q:+GMPDFN'>0
 S GMPARAM("QUIET")=1,GMPARAM("REV")=$P($G(^GMPL(125.99,1,0)),U,5)="R"
 S GMPLVIEW("ACT")=STATUS,GMPLVIEW("PROV")=0,GMPLVIEW("VIEW")=""
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
BUILD ; Build list for selected patient
 ;   Sets Global Array:
 ;   ^TMP("GMPLHS",$J,STATUS,0)
 ;                  
 ;   Piece 1:  GMPCNT     # of entries extracted
 ;         2:  GMPTOTAL   # of entries that exist
 N IFN,GMPCNT,NUM S (NUM,GMPCNT)=0 F  S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D
 . S IFN=+GMPLIST(NUM) Q:IFN'>0  D GETPROB(IFN)
 I $G(GMPCNT)'>0 K ^TMP("GMPLHS",$J) Q
 S ^TMP("GMPLHS",$J,STATUS,0)=GMPCNT_U_GMPTOTAL
 Q
GETPROB(IFN) ; Get problem data and set it to ^TMP array
 ;   Sets Global Arrays:
 ;   ^TMP("GMPLHS",$J,CNT,0)
 ;   Piece 1:  Pointer to ICD9 file #80
 ;         2:  Internal Date Last Modified
 ;         3:  Facility Name
 ;         4:  Internal Date Entered
 ;         5:  Internal Status (A/I/"")
 ;         6:  Internal Date of Onset
 ;         7:  Responsible Provider Name
 ;         8:  Service Name
 ;         9:  Service Abbreviation
 ;        10:  Internal Date Resolved
 ;        11:  Clinic Name
 ;        12:  Internal Date Recorded
 ;        13:  Problem Term (from Lexicon)
 ;        14:  Exposure String (AO/IR/EC/HNC/MST/CV/SHD)
 ;                        
 ;   ^TMP("GMPLHS",$J,CNT,"N")
 ;   Piece 1:  Provider Narrative
 ;                   
 ;   ^TMP("GMPLHS",$J,CNT,"IEN")
 ;   Piece 1:  Pointer to Problem file 9000011
 ;                   
 N DIC,DIQ,DR,DA,REC,DIAG,LASTMDT,NARR,SITE,ENTDT,STAT,ONSETDT,RPROV
 N SERV,SERVABB,RESDT,CLIN,RECDT,LEXI,LEX,PG,AO,EXP,HNC,MST,CV,SHD,IR,SCS
 S DIC=9000011,DA=IFN,DIQ="REC(",DIQ(0)="IE"
 S DR=".01;.03;.05;.06;.08;.12;.13;1.01;1.05;1.06;1.07;1.08;1.09;1.11;1.12;1.13;1.15;1.16;1.17;1.18"
 D EN^DIQ1
 S DIAG=REC(9000011,DA,.01,"I"),LASTMDT=REC(9000011,DA,.03,"I")
 S NARR=REC(9000011,DA,.05,"E"),SITE=REC(9000011,DA,.06,"E")
 S ENTDT=REC(9000011,DA,.08,"I"),STAT=REC(9000011,DA,.12,"I")
 S ONSETDT=REC(9000011,DA,.13,"I")
 S LEXI=REC(9000011,DA,1.01,"I")
 S LEX=REC(9000011,DA,1.01,"E")
 S RPROV=REC(9000011,DA,1.05,"E")
 S SERV=REC(9000011,DA,1.06,"E")
 S SERVABB=$$SERV(REC(9000011,DA,1.06,"I"),SERV)
 S RESDT=REC(9000011,DA,1.07,"I")
 S CLIN=REC(9000011,DA,1.08,"E")
 S RECDT=REC(9000011,DA,1.09,"I")
 S AO=+REC(9000011,DA,1.11,"I")
 S IR=+REC(9000011,DA,1.12,"I")
 S PG=+REC(9000011,DA,1.13,"I")
 S HNC=+REC(9000011,DA,1.15,"I")
 S MST=+REC(9000011,DA,1.16,"I")
 S CV=+REC(9000011,DA,1.17,"I")
 S SHD=+REC(9000011,DA,1.18,"I")
 K SCS D SCS^GMPLX1(DA,.SCS) S EXP=$G(SCS(1))
 S GMPCNT=GMPCNT+1,^TMP("GMPLHS",$J,GMPCNT,0)=DIAG_U_LASTMDT_U_SITE_U_ENTDT_U_STAT_U_ONSETDT_U_RPROV_U_SERV_U_SERVABB_U_RESDT_U_CLIN_U_RECDT_U_LEX_U_EXP
 S ^TMP("GMPLHS",$J,GMPCNT,"N")=NARR,^TMP("GMPLHS",$J,GMPCNT,"IEN")=IFN
 S:+LEXI>0 ^TMP("GMPLHS",$J,GMPCNT,"L")=LEXI_"^"_LEX
 D GETCOMM(IFN,GMPCNT)
 Q
GETCOMM(IFN,CNT) ; Get Active Comments for a Note
 ;   Sets Global Array:
 ;   ^TMP("GMPLHS",$J,CNT,"C",LOCATION,NOTE NMBR,0)
 ;                     
 ;   Piece 1:  Note Narrative
 ;         2:  Internal Date Note Added 
 ;         3;  Name of Note's Author 
 ;                        
 N IFN2,IFN3,LOC,NODE S LOC=0 Q:$D(^AUPNPROB(IFN,11))'>0  S IFN2=0
 F  S IFN2=$O(^AUPNPROB(IFN,11,IFN2)) Q:IFN2'>0  D
 . Q:$D(^AUPNPROB(IFN,11,IFN2,11))'>0
 . S LOC=+$G(^AUPNPROB(IFN,11,IFN2,0)),IFN3=0
 . F  S IFN3=$O(^AUPNPROB(IFN,11,IFN2,11,IFN3)) Q:IFN3'>0  D
 . . S NODE=$G(^AUPNPROB(IFN,11,IFN2,11,IFN3,0)) Q:$P(NODE,U,4)']""
 . . S ^TMP("GMPLHS",$J,CNT,"C",LOC,$P(NODE,U),0)=$P(NODE,U,3)_U_$P(NODE,U,5)_U_$P($G(^VA(200,+$P(NODE,U,6),0)),U)
 Q
SERV(X,SERV) ; Returns Service Name Abbreviation
 N ABBREV S ABBREV=$P($G(^DIC(49,+X,0)),U,2) S:ABBREV="" ABBREV=$E($G(SERV),1,5)
 Q ABBREV
