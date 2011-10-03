IBCIUT2 ;DSI/SLM - CLAIMSMANAGER MESSAGE UTILITIES ;21-DEC-2000
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
MSGHDR ;build message id segment
 ;
 K IBCIU
 S IBCIU(1)=$C(28),IBCIU(2)=$C(29),IBCIU(3)=$C(30),IBCIU(4)=$C(94),IBCIU(5)=$C(39),IBCIU(6)=$C(37)
 S IBCIAA="" F I=1:1:6 S IBCIAA=IBCIAA_IBCIU(I)
 K IBCIHDR S IBCIHDR=IBCIAA_"CLAIM"_IBCIU(1)
 ;
RSEG ;build route segment
 N X,X1,X2,X3,X4,Y
 S IBCIHDR=IBCIHDR_IBCIU(3)_IBCIU(3)
 S X=IBCIMT,X1=3,IBCIMT=$$FILL
 K X D NOW^IBCIUT1 S X=Y,X1=16,IBCIMDT=$$FILL
 S X="",X1=20,IBCIMCID=$$FILL,IBCIMP="H"
 S IBCIUID="DVAUSER",X=IBCIUID,X1=10,IBCIUID=$$FILL
 S IBCISAP="VISTA",X=IBCISAP,X1=20,IBCISAP=$$FILL
 S IBCIRAP="CLAIMS MANAGER",X=IBCIRAP,X1=20,IBCIRAP=$$FILL
 S IBCISI="",X=IBCISI,X1=30,X3=".",IBCISI=$$FILL K X3
 ;
 S IBCIHDR=IBCIHDR_IBCIMT_IBCIMDT_IBCIMCID_IBCIMP_IBCIUID
 S IBCIHDR=IBCIHDR_IBCIU(3)_IBCISAP_IBCIU(3)_IBCIRAP
 S IBCIHDR=IBCIHDR_IBCIU(3)_IBCISI_IBCIU(1)
 ;
 Q
FILL() ;pad x with characters
 ;
 ;Input variables
 ;  X  = input value in non-fixed format
 ;  X1 = desired length of the output (default is 80 if undefined)
 ;  X2 = justify 'R' or 'L' (if undefined or not [ R or L, default is 'L')
 ;  X3 = character you want x padded with (default is " ")
 ;  X4 = truncate flag - if [ 'T' and x>x1 it will be truncated (default is 'T')
 ;
 ;Output variable
 ;  Y
 ;
 S Y=""
 Q:'$D(X) Y
 ;
 ;initialize variables for fill
 ;
 I '$D(X1) S X1=80
 I X1<1 S X1=80
 I '$D(X2) S X2="L"
 I "RL"'[X2 S X2="L"
 I X2["R"&(X2["L") S X2="L"
 I '$D(X3) S X3=" "
 I X3']"" S X3=" "
 I '$D(X4) S X4="T"
 ;
 I X4["T"&($L(X)>X1) S Y=$E(X,1,X1) Q Y
 ;
 S Y="",$P(Y,X3,X1+1)="",Y=$E(Y,1,X1-$L(X))
 I X2["R" S Y=Y_X
 I X2["L" S Y=X_Y
 Q Y
 ;
 ;asnd(ibifn) comments
 ;Input Variable
 ;  ibifn
 ;Output Variable
 ;  y = 1 if successful, = 0 if not.
ASND(IBIFN) ;auto send to ClaimsManager
 N IBCIY S IBCIY=0,IBCIERR="" K PROBLEM
 Q:'$D(IBIFN) IBCIY
 ;change status in 351.9
 I IBCISNT'=3 D
 .S IBCIST=$S(IBCISNT=6:8,IBCISNT=5:5,IBCISNT=4:9,1:2)
 .D ST^IBCIUT1(IBCIST)
 ;
 D UPDT^IBCIADD1   ;update 351.9 for all cases
 ;
 I IBCISNT<3 D  ;a normal claim that has not been authorized
 .D EN^IBCIMSG,SEND
 .I '$G(PROBLEM) S IBCIY=1 D
 ..I $P(^IBA(351.9,IBIFN,0),U,15)'=1 D  ;set received by cm to yes
 ...S DIE="^IBA(351.9,",DA=IBIFN,DR=".15///1" D ^DIE K DIE,DA,DR
 ..I $P($G(^IBA(351.9,IBIFN,2,0)),U,4) D DCOM^IBCIUT4(IBIFN)
 ..I $$CKNER^IBCIUT1() D  Q  ;if no errors then...
 ...S (IBCISTAT,IBCIST)=3 D ST^IBCIUT1(IBCIST)    ;update status=3
 ...D DELTI^IBCIUT4   ;delete temp info when passed w/o errors
 ...D DELER^IBCIUT4   ;delete error information too
 ...D DASN^IBCIUT5(IBIFN)   ;remove the assigned to person
 ...Q
 ..D Z1AR^IBCIUT4           ;errors found then..
 ..S (IBCISTAT,IBCIST)=4 D ST^IBCIUT1(IBCIST)
 ..I IBCISNT=2 D COMMENT^IBCIUT7(IBIFN,4)  ; log a comment in auto-send
 ..Q                                       ; mode when errors are found
 .I $G(PROBLEM) S IBCIERR=$$P1^IBCIUT4(PROBLEM) D  ;comm errors
 ..S (IBCISTAT,IBCIST)=6 D ST^IBCIUT1(IBCIST) Q
 ;
 I IBCISNT=3 D  ;test send
 .D EN^IBCIMSG,SEND
 .I '$G(PROBLEM) S IBCIY=1 D
 ..I $$CKNER^IBCIUT1() S IBCISTAT=3 Q  ;no errors...
 ..D Z1AR^IBCIUT4 S IBCISTAT=4 Q  ;error(s) found
 .I $G(PROBLEM) S IBCIERR=$$P1^IBCIUT4(PROBLEM),IBCISTAT=6 Q  ;comm errors
 .D TST ;put in tmp global
 ;
 I IBCISNT=4!(IBCISNT=5) D  ;canceled, overridden
 .D EN^IBCIMSG,SEND
 .I '$G(PROBLEM) S IBCIY=1 D
 ..S IBCISTAT=$$STAT^IBCIUT1(IBIFN)
 ..D DELTI^IBCIUT4                ;delete temp information
 ..D DASN^IBCIUT5(IBIFN)          ;remove the assigned to person
 ..I IBCISNT=4 D DELER^IBCIUT4    ;delete errors
 .I $G(PROBLEM) D  ;comm error
 ..S (IBCISTAT,IBCIST)=$S(IBCISNT=5:11,IBCISNT=4:10,1:6)
 ..D ST^IBCIUT1(IBCIST)
 ..S IBCIERR=$$P1^IBCIUT4(PROBLEM)
 ;
 I IBCISNT=6 D  ;historical
 .S IBCISNT=1 D EN^IBCIMSG,SEND ;send first as a normal claim
 .I '$G(PROBLEM) D  Q
 ..I '$$CKNER^IBCIUT1() D Z1AR^IBCIUT4 ;store them
 ..H 2      ; pause between sendings to CM
 ..S IBCISNT=6 D EN^IBCIMSG,SEND ;reset ibcisnt to 6 and send again
 ..I '$G(PROBLEM) S IBCIY=1 D  Q
 ...S (IBCISTAT,IBCIST)=8 D ST^IBCIUT1(IBCIST)
 ...D DELTI^IBCIUT4    ; remove the temp nodes
 ...Q
 ..I $G(PROBLEM) D  Q  ;comm error on second send
 ...S (IBCISTAT,IBCIST)=6 D ST^IBCIUT1(IBCIST)
 ...S IBCIERR=$$P1^IBCIUT4(PROBLEM)
 .I $G(PROBLEM) D  Q  ;comm error on first send
 ..S (IBCISTAT,IBCIST)=6 D ST^IBCIUT1(IBCIST)
 ..S IBCIERR=$$P1^IBCIUT4(PROBLEM)
 ..S IBCISNT=6
 ;
 ; Add new send type - esg - 1/3/2002
 I IBCISNT=7 D         ; delete lines from a UB bill on CM
 . D EN^IBCIMSG,SEND
 . S IBCISTAT=""
 . I '$G(PROBLEM) S IBCIY=1
 . I $G(PROBLEM) S IBCIERR=$$P1^IBCIUT4(PROBLEM)
 . Q
 ;
 I '$G(IBCIERR) S IBCIERR=""
 Q IBCIY
 ;
WRT ;write the message to io
 ;
 N I,J,ICD0,LITMS,MOD,TOTMOD
 S IBCICC=0,IBCIOS=^%ZOSF("OS") D MSGHDR W IBCIHDR
 S FLUSH=$S(IBCIOS["MSM":"#",IBCIOS["OpenM":"!",1:"!")
 S IBCICC=IBCICC+$L(IBCIHDR) D ^IBCIUDF
 ;
 ; Data elements in the Header Segment
 F I=1:1:19 D
 .S IBCICC=IBCICC+$L(^TMP("IBCIMSG",$J,IBIFN,IBCICLNP,I))
 .I IBCICC>200 W @FLUSH S IBCICC=0
 .W ^TMP("IBCIMSG",$J,IBIFN,IBCICLNP,I)
 ;
 ; Determine the # of line items.  Write the data elements in the
 ; Line Segments (ExtLineID field through Units field)
 ;
 S LITMS=$P($G(^IBA(351.9,IBIFN,5,0)),U,4)
 I LITMS W IBCIU(1) F J=1:1:LITMS D
 .F I=20:1:52 D
 ..S IBCICC=IBCICC+$L(^TMP("IBCIMSG",$J,IBIFN,IBCICLNP,J,I))
 ..I IBCICC>200 W @FLUSH S IBCICC=0
 ..W ^TMP("IBCIMSG",$J,IBIFN,IBCICLNP,J,I)
 .;
 .W IBCIU(3)    ; field delimiter between Units and ICDCode
 .;
 .; icd codes - was node 53, now just an array
 .; Repeating Field
 .F I=1:1:$P($G(^TMP("IBCIMSG",$J,IBIFN,"ICD",J,0)),U,2) D
 ..S IBCICC=IBCICC+$L(^TMP("IBCIMSG",$J,IBIFN,"ICD",J,I))
 ..I IBCICC>200 W @FLUSH S IBCICC=0
 ..W ^TMP("IBCIMSG",$J,IBIFN,"ICD",J,I)
 ..I I'=$P(^TMP("IBCIMSG",$J,IBIFN,"ICD",J,0),U,2) W IBCIU(4)
 .;
 .W IBCIU(3)    ; field delimiter between ICDCode and Modifier
 .;
 .; cpt code node 54 multiple
 .; CPT Modifier(s). Repeating Field
 .S TOTMOD=$P(^TMP("IBCIMSG",$J,IBIFN,IBCICLNP,J,54,0),U,1)
 .F I=1:1:TOTMOD D
 ..S MOD=^TMP("IBCIMSG",$J,IBIFN,IBCICLNP,J,54,I)
 ..S IBCICC=IBCICC+$L(MOD)
 ..I IBCICC>200 W @FLUSH S IBCICC=0
 ..W MOD
 ..I I'=TOTMOD W IBCIU(4)
 .;
 .W IBCIU(3)    ; field delimiter between Modifier and UDF#1
 .;
 .; insert the user defined fields, 2 extra field delimiters, and
 .; a line segment repetition delimiter if we're not done
 .;
 .F I=1:1:25 W IBCIUDF(I),IBCIU(3)
 .W IBCIU(3),IBCIU(3)
 .I J'=LITMS W IBCIU(2)
 ;
 D CLEAN1
 Q
 ;
SEND ;open the tcp/ip port and send msg then read response
 I '$$OPENUSE^IBCIUT5 S PROBLEM=99 Q
 W $C(1) D WRT W $C(3),@FLUSH
 D READ^IBCIUT3(.IBCIZ,.PROBLEM,IBCISOCK)
 KILL FLUSH,IBCICC,IBCIOS,IBCISOCK
 Q
 ;
TST ;if test send, put errors in tmp global
 N IBCIDA,IBCIDA1,IBCICNT K ^TMP("IBCITST",$J) S IBCICNT=1
 S IBCIDA=0 F  S IBCIDA=$O(IBCIZ1(IBCIDA)) Q:'IBCIDA  D
 .S IBCIDA1=0 S ^TMP("IBCITST",$J,IBCICNT,IBCIDA1)=IBCIZ1(IBCIDA,IBCIDA1)
 .F  S IBCIDA1=$O(IBCIZ1(IBCIDA,IBCIDA1)) Q:'IBCIDA1  D
 ..S ^TMP("IBCITST",$J,IBCICNT,1,IBCIDA1,0)=IBCIZ1(IBCIDA,IBCIDA1)
 .S IBCICNT=IBCICNT+1
 Q
 ;
CLEAN1 ; clean up the variables
 K ^TMP("IBCIMSG",$J),IBCIU,IBCICLNP,IBCIUDF
CLEAN ;
 K ^TMP("IBXSAVE",$J)
 K X,Y,N1,D0,DA,DIC,DIE,DR,I,II,J,%,CT
 K IBCIAA,IBCIAPC,IBCIAPID,IBCIBDPS,IBCIBPDE
 K IBCIBPDI,IBCIBPFI,IBCIBPID,IBCIBPLA,IBCIBPMI,IBCIBPSP
 K IBCIBPTI,IBCIBPUP,IBCICL,IBCICPT,IBCIDE,IBCIDFN,IBCIBDOS
 K IBCIDOB,IBCIEB,IBCIEBID,IBCIEDOS,IBCIET,IBCIHDR
 K IBCILSEG,IBCILSTA,IBCIMCID,IBCIMDT,IBCIMP
 K IBCIOGID,IBCIOID,IBCIPAC,IBCIPID,IBCIPOS,IBCIPPID
 K IBCIPTFI,IBCIPTLA,IBCIPTMI,IBCIRAP,IBCIRPDE,IBCIRPDI,IBCIRPFI
 K IBCIRPID,IBCIRPLA,IBCIRPMI,IBCIRPSP,IBCIRPTI,IBCIRPUP,IBCISAMT
 K IBCISAP,IBCISEX,IBCISI,IBCISPAI,IBCISPC,IBCISPDE,IBCISPDI
 K IBCISPFI,IBCISPID,IBCISPLA,IBCISPMI,IBCISPSP,IBCISPTI,IBCISPUP
 K IBCIST,IBCITC,IBCITOS,IBCIUID,IBCIUNIT,IBCIXLID,IBX,IBY
 K IENS,NODE3,NODE4,NODE50,NODE51,NODE52,RCD1,CPD1
 K IBCIZ,IBCIZ1,IBXARRAY,IBXARRY,IBXDAT1,IBXDATA,IBXERR
 K IBCITSI,X1,X2,X3,X4,IBCILSI,CTR
 Q
 ;
