SROICD ;BIR/SJA - CODE SET VERSIONING UTILITY ;27 Sep 2013  4:00 PM
 ;;3.0;Surgery;**116,127,177**;24 Jun 93;Build 89
 ;
 ; Reference to $$ICDDATA^ICDXCODE supported by DBIA #5699
 ; Reference to $$LS^ICDEX supported by DBIA #5747
 ; Reference to $$CODEC^ICDEX supported by DBIA #5747
 ; Reference to $$CODEN^ICDEX supported by DBIA #5747
 ; Reference to $$SYS^ICDEX supported by DBIA #5747
 ; Reference to $$VST^ICDEX supported by DBIA #5747
 ; Reference to $$SEARCH^ICDSAPI supported by DBIA #5757
 ; Reference to $$DIAGSRCH^LEX10CS supported by DBIA #5681
 ; Reference to $$IMPDATE^LEXU supported by DBIA #5679
 ; Reference to $$FREQ^LEXU supported by DBIA #5679
 ; Reference to $$MAX^LEXU supported by DBIA #5679
 ;
ICDVST(SRCODE) ; Output Short Description, called from SRCUSS
 ; -- Input SRCODE in external code (e.g. "100.0" or "H54.0"
 N SRIEN,SRVST
 S SRIEN=+$$CODEN^ICDEX($G(SRCODE),80)
 I SRIEN<1 Q ""
 S SRVST=$$VST^ICDEX(80,SRIEN)
 Q SRVST
ICDC(SRCODE) ; output principal ICD
 N SRC,SRSDATE,SRDA
 I $D(SRCODE),SRCODE="" Q
 S SRDA=$S($G(SRIEN):SRIEN,$D(DA(2)):DA(2),$D(DA(1)):DA(1),$D(D0):D0,1:"")
 S SRC=$$ICD(SRDA,SRCODE)
 Q $P(SRC,"^",2,4)
 ;
ICD(SRIEN,SRC) ;
 N SRSYS,SRICD,SRDATE
 S SRDATE=$P($P($G(^SRF(SRIEN,0)),"^",9),".")
 S SRSYS=$$ICDSYS(SRDATE)
 S SRICD=$$ICDDATA^ICDXCODE(SRSYS,SRC,SRDATE,"I")
 Q SRICD
 ;
ICDSYS(SRDT,SRICDTYP) ; determine ICD coding system 
 ; If date of interest is null, today's date will be assumed
 ; If SRICDTYP is null, Diagnosis is assumed for code type
 N SRSYS,SRIMPDT
 S SRDT=$S($G(SRDT):$P(SRDT,"."),1:DT)
 S SRIMPDT=$$IMPDATE("10D")
 ; JAS - 06/12/13 - PATCH 177 - Modified ICD-9 to return proper 3 character coding system abbrev.
 S SRSYS=$S(SRDT'<SRIMPDT:"10D",1:"ICD")
 I $G(SRICDTYP)="DIAG" S SRSYS=$S(SRSYS="10D":"10D",1:"ICD")
 I $G(SRICDTYP)="PROC" S SRSYS=$S(SRSYS="10D":"10P",1:"ICP")
 ; END 177
 Q SRSYS
 ;
ICDSTR(SRIEN) ; return either "(ICD9)" or "(ICD10)" string
 N SRDT,SRSYS
 S SRDT=$P($P($G(^SRF(SRIEN,0)),"^",9),"."),SRDT=$S($G(SRDT):SRDT,1:DT)
 S SRSYS=$$ICDSYS(SRDT),SRSYS=$S(SRSYS="10D":"(ICD10)",1:"(ICD9)")
 Q SRSYS
 ;
ICD910(SRIEN) ; return either "9" or "10"
 N SRDT,SRSYS
 S SRDT=$P($P($G(^SRF(SRIEN,0)),"^",9),"."),SRDT=$S($G(SRDT):SRDT,1:DT)
 S SRSYS=$$ICDSYS(SRDT),SRSYS=$S(SRSYS="10D":"10",1:"9")
 Q SRSYS
IMPDATE(SRCODSYS) ; a wrapper for IMPDATE API
 Q $$IMPDATE^LEXU(SRCODSYS)
 ;
P80 ;No longer Used.  ICD-9/ICD-10 diagnosis selection - called by input transform
 N DIC,SRDA,SRDT,SRSYS
 S SRDA=$S($G(SRIEN):SRIEN,$D(DA(2)):DA(2),$D(DA(1)):DA(1),$D(D0):D0,1:"") I 'SRDA K X Q
 S SRDT=$S($G(SRDA):$P($P(^SRF(SRDA,0),"^",9),"."),1:DT),SRSYS=$$ICDSYS(SRDT)
 I $L(X)>100!($L(X)<1) K X Q
 I SRSYS["10" S SRTXT=X D LEX Q
 S Y=$$SEARCH^ICDSAPI("DIAG",("I $$LS^ICDEX(80,+Y,"""_SRDT_""")=1"),"QEMZ",SRDT) S:Y>0 X=+Y
 I Y'>0 S X="" Q
 Q
ASKOK(SRTOTAL) ;
 ; -- See default setting of SRASK at LEX+8
 I $G(SRASK)=1 D  Q
 . D EN^DDIOL("A total of "_$G(SRTOTAL)_" Entries found for this search.","","!!")
 . D EN^DDIOL("Please refine your Search!")
 . D EN^DDIOL(" ")
 . H 3 S SROK=0
 . Q
 ;
 I $G(SRASK)=2 D  Q
 . W !!,"Searching for """_SRICDTXT_""" requires inspecting "_$G(SRTOTAL)_" records to determine"
 . W !,"if they match the search criteria. This could take quite some time. Suggest"
 . W !,"refining the search by further specifying """_SRICDTXT_""".",!
 . ;
 . N DIR,X,Y
 . S DIR(0)="Y",DIR("A")="Do you wish to continue (Y/N)"
 . S DIR("B")="No"
 . S DIR("?")="Answer 'Y' for 'Yes' to continue searching on "_SRICDTXT_" or 'N' for 'No' to refine search criteria."
 . D ^DIR
 . I $D(DIROUT)!($D(DIRUT))!($D(DTOUT))!($D(DTOUT)) S SROK=0 Q
 . S SROK=Y
 . I SROK=1 W !,"   Searching...."
 . W !
 Q
LEX N %DT,DIROUT,DUOUT,DTOUT,SREXIT,SRICDDT,SRICDTXT,SRICDUP,SRICDY,XX,SRTOT,SROK,SRZZONE
 ; Begin Recursive Loop
 S SRICDTXT=$G(X) Q:'$L(SRICDTXT)
 ; RBD - 10/15/13 - PATCH 177 - Spacebar search functionality added.
 I SRICDTXT=" " S SRICDTXT=$$SPACEBAR("^ICD9(") I SRICDTXT=" " K SRICDY G LOOK2
 ; End 177
 I $L(SRICDTXT)<2 D  S X="" Q
 . D EN^DDIOL("Please enter at least the first two characters of the ICD-10","","!!?5")
 . D EN^DDIOL("code or code description to start the search.","","!?5")
 . D EN^DDIOL(" ")
 . Q
 S:'$G(SRASK) SRASK=2
 S SRTOT=$$FREQ^LEXU(SRICDTXT) ;IA 5679
 I SRTOT>$$MAX^LEXU(30) D ASKOK(SRTOT) Q:'$G(SROK)
 S SRICDDT=$G(SRDT),SREXIT=0
 K SRASK,SROK
LOOK ; Lookup
 Q:+($G(SREXIT))>0  K SRICDY
 S SRICDY=$$DIAGSRCH^LEX10CS(SRICDTXT,.SRICDY,SRICDDT,30)
 S:$O(SRICDY(" "),-1)>0 SRICDY=+SRICDY
 ; RBD - 10/15/13 - PATCH 177 - LOOK2 label added for Spacebar logic
LOOK2 I +SRICDY'>0 D  K X,Y Q
 . D EN^DDIOL("No records found matching the value entered, revise search or enter ""?""","","!?5")
 . D EN^DDIOL("for help.","","!?5")
 . D EN^DDIOL(" ","","!?4")
 . Q
 ; RBD - 10/15/13 - PATCH 177 - 8 items at a time changed to 4
 S XX=$$SEL^SROICDL(.SRICDY,4)
 ; End 177
 I $D(DUOUT)&('$D(DIROUT)) K:'$D(SRICDNT) X Q
 I $D(DTOUT)&('$D(DIROUT)) S SREXIT=1 K X Q
 I $D(DIROUT) S SREXIT=1 K X Q
 ; Abort if timed out or user enters "^^"
 I $D(DTOUT)!($D(DIROUT)) S SREXIT=1 K X Q
 ; Up one level (SRICDUP) if user enters "^"
 ; Quit if already at top level and user enters "^"
 I $D(DUOUT),'$D(DIROUT),$L($G(SRICDUP)) K X Q
 ; No Selection
 I '$D(DUOUT),XX=-1 S SREXIT=1
 ; Code Found and Selected
 I $P(XX,";")'="99:CAT" S Y=+$$ICDDATA^ICDXCODE("10D",$P($P(XX,"^"),";",2)) S SREXIT=1 D  Q
 . ; RBD - 10/15/13 - PATCH 177 - Spacebar logic added.
 . D SAVSPACE("^ICD9(",Y)
 . ; End 177
 . ;CHOOSE 1-5: 1  003.0   ICD-9  003.0  SALMONELLA ENTERITIS  (C/C)
 . W:'$D(SRZZONE) "  ",$P(XX,";",2),"  ICD-10  ",$$VST^ICDEX(80,Y)
 ; Category Found and Selected
 D NXT G:+($G(SREXIT))'>0 LOOK
 Q
NXT ; Next
 Q:+($G(SREXIT))>0  N SRICDNT,SRICDND,SRICDX
 S SRICDNT=$G(SRICDTXT),SRICDND=$G(SRICDDT),SRICDX=$G(XX)
 N SRICDTXT,SRICDDT S SRICDTXT=$P($P(SRICDX,"^"),";",2),SRICDDT=SRICDND
 G LOOK
 Q
 ; RBD - 10/15/13 - PATCH 177 - Spacebar save & retrieval APIs added
 ; retrieves the last code selected by the user - space bar recall
 ; logic here
SPACEBAR(SRROOT) ;
 N SRICDIEN,SRRTV
 S SRRTV=" " I SRROOT="^ICD9(" D
 . S SRICDIEN=$G(^DISV(DUZ,SRROOT))  ; subscription to ICR #510
 . I $L(SRICDIEN) S SRRTV=$$CODEC^ICDEX(80,SRICDIEN)
 Q SRRTV
 ;
 ; store the selected code for the space bar recall feature above
SAVSPACE(SRROOT,SRRETV) ;
 I +$G(DUZ)=0 Q
 ; Subscription to ICD #510 needed for call to RECALL API below
 I SRROOT="^ICD9(" D RECALL^DILFD(80,SRRETV_",",+DUZ) Q
 Q
 ;
 ; End 177
OUT(SRICDC) ; called by output transform fields of the ICD diagnosis code fields
 N SRDA,SRDT,SRY
 ;JAS - 5/31/13 - PATCH 177 - Rewrote the following line since it was grabbing the wrong ien.
 S SRDA=$S($G(SRIEN):SRIEN,$G(SRTN):SRTN,$D(DA(1)):DA(1),$D(D0):D0,1:"")
 S SRDT=$P($P($G(^SRF(SRDA,0)),"^",9),".")
 ;JAS - 4/18/13 - PATCH 177 - Either internal or external value could be passed in, so made changes to handle that
 I SRICDC?1N.N S SRY=$$ICDDATA^ICDXCODE("DIAG",SRICDC,SRDT,"I")
 E  S SRY=$$ICDDATA^ICDXCODE("DIAG",SRICDC,SRDT,"E")
 ;End 177
 Q $P(SRY,"^",2)
 ;
SCRN(SRCODE) ;screen for active ICD codes
 N SRSTAT,SRDA,SRDT
 S SRDA=$S($G(SRIEN):SRIEN,$D(DA(2)):DA(2),$D(DA(1)):DA(1),$D(D0):D0,1:"")
 S SRDT=$S($G(SRDA):$P($P(^SRF(SRDA,0),"^",9),"."),1:DT)
 S SRSTAT=$$LS^ICDEX(80,SRCODE,SRDT)
 Q $S(SRSTAT<1:0,1:1)
 ;
ICDSRCH ; To handle ICD ICD-9/10 Diagnosis Code Searches when ^DIC or ^DIE cannot be used
 ; SRPRMT - For specific label, this field needs to be set from calling routine
 ; SRDEF - For displaying the default field value at diagnosis prompt
 ; X & Y variables need to be newed prior to calling this tag
 I $G(SRPRMT)="" S SRPRMT=" Select ICD Diagnosis "
 N SRDT,SRSYS
 S SRDT=$P($P($G(^SRF(SRTN,0)),"^",9),"."),SRDT=$S($G(SRDT):SRDT,1:DT),SRSYS=$$SYS^ICDEX("DIAG",SRDT)
 W !!,SRPRMT_$$ICDSTR^SROICD(SRTN)_": "_$S($G(SRDEF)'="":SRDEF_"// ",1:"") R X:DTIME
 I X="",$G(SRDEF)'="" S X=SRDEF
 ; RBD - 10/15/13 - PATCH 177 - Needs to Quit when X Null also
 I (X="")!(X="^")!(X="@") Q
 ; End 177
 I X["?" D  K X,Y G ICDSRCH
 .N SRTAG,SRFMT S SRTAG=""
 .I SRSYS=30 S SRTAG=$S(X["???":"D3^SROICDGT",X["??":"D2^SROICDGT",X["?":"D1^SROICDGT",1:"D1^SROICDGT") D @SRTAG Q
 .I SRSYS=1 S SRTAG="Answer with ICD-9 DIAGNOSIS CODE NUMBER, or DESCRIPTION."
 .S SRFMT=$S(X["??":"!?8",1:"!?5")
 .D EN^DDIOL(SRTAG,"",SRFMT)
 .Q
 I SRSYS=1 S Y=$$SEARCH^ICDSAPI("DIAG","","QEMZ",SRDT)
 E  D LEX^SROICD
 ;JAS - 11/07/13 - PATCH 177 - Need to Kill Y too prior to returning to ICDSRCH
 I $G(Y)'>0!($G(Y)="") D  K X,Y G ICDSRCH
 .I SRSYS=1 W !,?6,"Enter the ICD Diagnosis code for the principal postoperative diagnosis.",!,?6,"Screen prevents selection of inactive diagnosis."
 K SRPRMT,SRDEF
 Q
 ;
TEST1 ;
 ; do not ask question
 S SRASK=1
 S X="FRACTURE",SRDT=3150101 D LEX
 Q
TEST2 ;
 ; ask question
 S SRASK=2
 S X="FRACTURE",SRDT=3150101 D LEX
 Q
