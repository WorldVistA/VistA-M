IBDF18E ;ALB/CJM - ENCOUNTER FORM - PCE DEVICE INTERFACE utilities ;04-OCT-94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3,25,38,37**;APR 24, 1997
 ;
SEND(FORMID,PROVIDER,PROVTYPE,BUBBLES,HANDPRNT,CHECKOUT,PXCA,DYNAMIC) ;builds the PCXA array and passes it to PCE, updates form tracking status
 ;input:
 ;   FORMID = the unique id assigned to the printed form, points to the FORM TRACKING file
 ;   PROVIDER=pointer to NEW PERSON file (#200) (optional)
 ;   PROVTYPE= P:=primary,S:=secondary (optional)
 ;   BUBBLES = an array which should be passed by reference, BUBBLES is the list of bubbles marked on the form, subscripted by pointers to the BUBBLES multiple in the FORM DEFINITION TABLE
 ;   HANDPRNT is the list of hand print fields marked on the form - subscripted by pointers to the HAND PRINT FIELDS multiple in the FORM DEFINITION TABLE, the value being what was input (HANDPRINT(<ien>)=<value>) - should be passed by reference
 ;   CHECKOUT = checkout data@time
 ;   DYNAMIC = an array which should be passed by reference, contains the list of bubbles selected from dynamic selection lists
 ;
 ;output:
 ;    = 0 if the data is not passed to PCE
 ;    = 1 if PXCA is passed by reference, and the data is passed to PCE
 ;    the PXCA array is returned, principally to aid in debugging
 ;
 ;example: S RETURN=$$SEND^IBDF18E(3,DOCTOR,"P",.BUBBLES,.HANDPRNT)
 ;
 N D,D0,NODE,FORMTYPE,PXCASTAT,IBAPPT,IBCLINIC,IBDFN,VALUE,VALUE1,PI,TEXT,HEADER,QLFR,BUB,STATUS,IBSOURCE,HAND,COUNT,FID,FNM,TEMP,ITEM,TYPE,IBDF,LEX,PLEX,QUANTITY,NARR,SLCTN
 ;
 S FORMID("WSID")=$G(^TMP("IBD-SCAN-RAWDATA",$J,"WSID"))
 S FORMID("PAGE")=+$P($G(^TMP("IBD-SCAN-RAWDATA",$J,"FD1")),"PAGE=",2)
 K PXCA
 S (PXCA,PXCASTAT)=""
 ;
 ;check that the required parameters were passed
 I '$G(FORMID) D LOGERR^IBDF18E2(3579601,.FORMID) Q 0
 ;
 ;there must be an entry in form tracking - retrieve it into FORMID array
 I '$$TRACKING^IBDF18E0(.FORMID) D LOGERR^IBDF18E2(3579501,.FORMID) Q 0
 ;
 ;there must be a form definition table
 S FORMTYPE=$P(NODE,"^",4)
 I 'FORMTYPE S STATUS=$$FSCND^IBDF18C(FORMID,12) Q 0
 I '$G(^IBD(357.95,FORMTYPE,0)) S STATUS=$$FSCND^IBDF18C(FORMID,12) Q 0
 ;
 S PROVIDER=$G(PROVIDER)
 S PROVTYPE=$G(PROVTYPE)
 ;
 ;build the encounter node and source node from form tracking
 S PXCA("ENCOUNTER")=FORMID("APPT")_"^"_FORMID("DFN")_"^"_FORMID("CLINIC")_"^"_PROVIDER_"^^^^^^^^^^"_CHECKOUT_"^"_PROVTYPE
 S PXCA("SOURCE")=+FORMID("SOURCE")_"^"_DUZ_"^"_FORMTYPE_"^^"_FORMID
 ;
 ;now for each bubble in BUBBLES() add to TEMP()
 S BUB=0 F  S BUB=$O(BUBBLES(BUB)) Q:BUB=""  S:BUB NODE=$G(^IBD(357.95,FORMTYPE,1,BUB,0)) D
 .N SUBHDR
 .I 'BUB!(NODE="") D LOGERR^IBDF18E2(3579502,.FORMID,BUB,BUBBLES(BUB)) Q
 .S $P(NODE,"^",8)=$S($D(^IBD(357.95,FORMTYPE,1,BUB,2))&($P($G(^IBD(357.95,FORMTYPE,1,BUB,2)),"^",1)]""):$P($G(^IBD(357.95,FORMTYPE,1,BUB,2)),"^",1),1:$P(NODE,"^",8))
 .S VALUE=$P(NODE,"^",4)
 .S PI=$P(NODE,"^",3)
 .S TEXT=$P(NODE,"^",8)
 .S FNM=$P(NODE,"^",5)
 .; -- strip :: code from TEXT if it exists
 .I TEXT[" :: " S TEXT=$$DISP^IBDFM1(TEXT)
 .;I TEXT[" :: ",PI,VALUE D
 .;.S (Y,X)=VALUE X $G(^IBE(357.6,PI,14)) I Y]"" S TEXT=$P(TEXT," :: "_Y)
 .S SUBHDR=$G(^IBD(357.95,FORMTYPE,1,BUB,1))
 .;
 .; -- the following line causes the subheader and display text to
 .;    to be concatenated except for IB, which can pass an alternate
 .;    text.  (some don't like this when passed to Problem List)
 .;    This may need to be re-visited in the future
 .I +FORMID("SOURCE")'=1,$L(SUBHDR),($L(SUBHDR)+$L(TEXT)<80) S TEXT=SUBHDR_" "_TEXT
 .S HEADER=$P(NODE,"^",9)
 .S FID=$P(NODE,"^",6) I FID="" S FID=$P(NODE,"^") ;PANDAS uses piece 1 to number each bubble - does not use piece 6
 .S ITEM=$P(NODE,"^",12)
 .S QLFR=$P(NODE,"^",10)
 .S QUANTITY=$P(NODE,"^",13)
 .S SLCTN=$P(NODE,"^",14) ;--added for modifiers, pointer to file 357.3
 .;
 .; -- if text contains 'x #' for quantity, strip it
 .;I +QUANTITY I TEXT[(" x "_QUANTITY) S TEXT=$TR(TEXT," x "_QUANTITY)
 .I +QUANTITY I TEXT[(" x "_QUANTITY) D
 ..S X=" x "_QUANTITY
 ..S TEXT=$E(TEXT,1,$F(TEXT,X)-($L(X)+1))_$E(TEXT,$F(TEXT,X),$L(TEXT))
 .;
 .S TYPE="",(LEX,NARR)=0
 .I $D(^IBD(357.95,FORMTYPE,1,BUB,2)) S LEX=$P($G(^IBD(357.95,FORMTYPE,1,BUB,2)),"^",2)
 .D SETTEMP^IBDF18E1
 .D CODES^IBDF18E0
 K BUBBLES
 ;
 ;now for each bubble in DYNAMIC() add to TEMP()
 S FID="" F  S FID=$O(DYNAMIC(FID)) Q:FID=""  S COUNT="" F  S COUNT=$O(DYNAMIC(FID,COUNT)) Q:COUNT=""  S BUB=$O(^IBD(357.96,FORMID,"AC",FID,+COUNT,0)) S:BUB NODE=$G(^IBD(357.96,FORMID,1,BUB,0)) D
 .I 'BUB!(NODE="") D LOGERR^IBDF18E2(3579602,.FORMID,FID,DYNAMIC(FID,COUNT)) Q
 .S VALUE=$P(NODE,"^",4)
 .S PI=$P(NODE,"^",3)
 .S TEXT=$P(NODE,"^",8)
 .; -- strip :: code from TEXT if it exists
 .I TEXT[" :: " S TEXT=$$DISP^IBDFM1(TEXT)
 .;I TEXT[" :: " S TEXT=$P(TEXT," :: ")
 .S HEADER=""
 .S FID=$P(NODE,"^",6)
 .S ITEM=$P(NODE,"^")
 .S QLFR=$P(NODE,"^",10)
 .S TYPE=""
 .S LEX=0
 .S SLCTN=$P(NODE,"^",14) ;--added for modifiers, pointer fo file 357.3
 .D SETTEMP^IBDF18E1
 K DYNAMIC
 ;
 ;now for each hand print field in HANDPRNT() add to TEMP()
 ;
 S HAND=0 F  S HAND=$O(HANDPRNT(HAND)) Q:HAND=""  S:HAND NODE=$G(^IBD(357.95,FORMTYPE,2,HAND,0)) D
 .I 'HAND!(NODE="") D LOGERR^IBDF18E2(3579503,.FORMID,HAND,HANDPRNT(HAND)) Q
 .S TYPE=$P(NODE,"^",17)
 .S VALUE=HANDPRNT(HAND) S:$E(VALUE,$L(VALUE))="," VALUE=$E(VALUE,1,$L(VALUE)-1)
 .;
 .;what was printed may need transformation/formating
 .S VALUE1=VALUE,VALUE=$$HPTRNS^IBDFU91(TYPE,VALUE,.FORMID)
 .;
 .; -- failed the input transform
 .I VALUE="" D LOGERR^IBDF18E2(3579504,.FORMID,HAND,VALUE1,"","",TYPE) Q
 .;
 .S PI=$P(NODE,"^",4)
 .S TEXT=$P(NODE,"^",7)
 .S HEADER=$P(NODE,"^",9)
 .S FID=$P(NODE,"^",8)
 .S ITEM=$P(NODE,"^",12)
 .S QLFR=$P(NODE,"^",10)
 .S (LEX,NARR)=0
 .S SLCTN=$P(NODE,"^",14) ;--added for modifiers, pointer to file 357.3
 .I $P($G(^IBE(357.2,+$E(FID,2,$L(FID)),0)),U,18)=3 S NARR=1 ;Send both code and narrative
 .D SETTEMP^IBDF18E1
 K HANDPRNT
 ;
 ; --added to copy visit modifiers if any
 ;
 D:$D(TEMP("ENCOUNTER")) VSTPXCA^IBDF18E0
 ;
 D SETPXCA^IBDF18E0,PRO^IBDF18E0,SC^IBDF18E0
 ;
 ; -- do misc. passing to other packages that do not use PCE
 ;
 D ^IBDF18E4
 ;
 ;
 I $D(PXCA("IBD-ABORT")) D  S PXCASTAT=0 G SENDQ
 .S I="" F  S I=$O(PXCA("IBD-ABORT",I)) Q:I=""  S J="" F  S J=$O(PXCA("IBD-ABORT",I,J)) Q:J=""  D
 ..I +PXCA("IBD-ABORT",I,J)=3 K PXCA("IBD-ABORT",I,J) Q
 ..D LOGERR^IBDF18E2(3570004,.FORMID,"",$P(PXCA("IBD-ABORT",I,J),"^",2))
 ;
 I +FORMID("SOURCE")=1 D QUE^IBDF18E3 G STAT
 ;
 S IBD("AICS")=1 ;flag for IBDF PCE EVENT protocol
 S IBD("PASSFLAG")=+$P($G(^IBD(357.09,1,0)),"^",7)
 I $G(IBD("PASSFLAG"))<2 D VALIDATE^PXCA(.PXCA) I '$D(PXCA("ERROR")) D BACKGND^PXCA(.PXCA,.PXCASTAT)
 I $G(IBD("PASSFLAG"))>1 D FOREGND^PXCA(.PXCA,.PXCASTAT)
 K IBD("AICS"),IBD("PASSFLAG")
 ;
STAT S STATUS=$$FSCND^IBDF18C(FORMID,$S(PXCASTAT=0:4,PXCASTAT=1:3,1:12),$S(PXCASTAT=0:"PCE RETURNED AN ERROR",1:""))
 ;
 ; -- kill erroneous inpatient warnings
 I $D(PXCA("WARNING","ENCOUNTER"))>0 D INPT^IBDF18E0($G(FORMID("DFN")),$G(FORMID("APPT")))
 ;
 ; -- log pce errors and warnings in AICS Error file
 I $O(PXCA("ERROR",""))'=""!($O(PXCA("WARNING",""))'="") S FORMID("SOURCE")=99 D LOGERR^IBDF18E2(3570001,.FORMID)
 ;
 ; -- if pce returns an error unflag all pages as received and delete
 ;    all scanned data so data can be re-scanned
SENDQ I $O(PXCA("ERROR",""))'=""!($O(PXCA("IBD-ABORT",""))'="") D UNRECV^IBDFBK2(FORMID)
 Q +$G(PXCASTAT)
