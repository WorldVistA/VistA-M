SRSCOR ;B'HAM ISC/SJA - Surgery/CoreFLS API ; [ 12/6/01  8:59 AM ]
 ;;3.0; Surgery ;**107,127**;24 Jun 93
 ;
 ; Reference to $$MOD^ICPTMOD supported by DBIA #1996
 ; Reference to $$BLDSEG^CSLSUR1 is supported by DBIA #3498
 ; Reference to ^DIC(45.3 is supported by DBIA #218
 ; Reference to ^TMP("CSLSUR1" is supported by DBIA #3498
 ;
ST(SRTN) S X="CSLSUR1" X ^%ZOSF("TEST") G:'$T EXIT
 N DYNOTE,II,JJ,MM,L,LSS,LSSC,LSSN,NSSIEN,OCIEN,OCPT,OMIEN,OR,ORN,PM,PMIEN,SPF,SRNODE0,SRNODE30,SRNODE31,SROP,SURGN,ASURG,SRICN,SRICPT,SRSP,SROP,SROPER
 K ^TMP("CSLSUR1",$J)
 S SRNODE0=$G(^SRF(SRTN,0)),SRNODE30=$G(^SRF(SRTN,30)),SRNODE31=$G(^SRF(SRTN,31))
AR1 ; Schedule ID
 S ^TMP("CSLSUR1",$J,1)=SRTN
AR2 ; Patient ID (DFN) and ICN
 S X="MPIF001",SRICN="" X ^%ZOSF("TEST") I $T S SRICN=$$GETICN^MPIF001($P(SRNODE0,"^"))
 S ^TMP("CSLSUR1",$J,2)=$P(SRNODE0,"^")_"^"_$S($P(SRICN,"^")=-1:"",1:SRICN)
AR3 ; Type of Action 
 S ^TMP("CSLSUR1",$J,3)=SRTYPE
 ;$S(SRTYPE=1:"NEW",SRTYPE=2:"EDIT",SRTYPE=3:"CANCEL",SRTYPE=4:"DELETE",1:"")
AR4 ; Date/Time of Surgery
 S ^TMP("CSLSUR1",$J,4)=$P(SRNODE31,"^",4)_"^"_$P(SRNODE31,"^",5)_"^"_$P(SRNODE0,"^",9)
 ;
AR5 ; Principle CPT code & Name
 S SROP=$G(^SRF(SRTN,"OP")),^TMP("CSLSUR1",$J,5,0)=$P(SROP,"^")
 I +$P(SROP,"^",2) S SRICPT=$$CPT^ICPTCOD($P(SROP,"^",2),$P($G(^SRF(SRTN,0)),"^",9)),^TMP("CSLSUR1",$J,5,1)=$P(SRICPT,"^",2)_"^"_$P(SRICPT,"^",3)
 ;
 ; CPT modifiers for principle code (X = sequential number)
 S PM=0 F  S PM=$O(^SRF(SRTN,"OPMOD",PM)) Q:'PM  S PMIEN=$P($G(^(PM,0)),"^") D
 .S ^TMP("CSLSUR1",$J,5,1,PM)=$P($$MOD^ICPTMOD(PMIEN,"I",$P($G(^SRF(SRTN,0)),"^",9)),"^",2,3)
 ;
 ; Other CPT codes and names (N = value greater than 1)
 S II=0,JJ=1 F  S II=$O(^SRF(SRTN,13,II)) Q:'II  S OCIEN=$G(^(II,2)) D
 .I +OCIEN S OCPT=$$CPT^ICPTCOD(+OCIEN,$P($G(^SRF(SRTN,0)),"^",9)) S JJ=JJ+1,^TMP("CSLSUR1",$J,5,JJ)=$P(OCPT,"^",2)_"^"_$P(OCPT,"^",3)
 .;
 .;CPT code modifiers
 .S MM=0 F  S MM=$O(^SRF(SRTN,13,II,"MOD",MM)) Q:'MM  S OMIEN=$G(^SRF(SRTN,13,II,"MOD",MM,0)),^TMP("CSLSUR1",$J,5,JJ,MM)=$P($$MOD^ICPTMOD(OMIEN,"I",$P($G(^SRF(SRTN,0)),"^",9)),"^",2,3)
AR6 ; Surgeon ID & Name
 S SURGN=$P($G(^SRF(SRTN,.1)),"^",4)
 I +SURGN S ^TMP("CSLSUR1",$J,6)=SURGN_"^"_$P($G(^VA(200,+SURGN,0)),"^")
AR7 ; Surgical Specialty Code & Name
 S LSSC=+$P(SRNODE0,"^",4),LSS=$G(^SRO(137.45,LSSC,0)),LSSN=$P(LSS,"^")
 S NSSIEN=$P(LSS,"^",2)
 I +NSSIEN S ^TMP("CSLSUR1",$J,7)=$P($G(^DIC(45.3,+NSSIEN,0)),"^",1,2)
AR8 ; Local Surgical Specialty Code & Name
 I +LSSC!(LSSN'="") S ^TMP("CSLSUR1",$J,8)=$P(LSS,"^",4)_"^"_LSSN
AR9 ; Operating Room
 S OR=$P(SRNODE0,"^",2),JJ=$P($G(^SRS(+OR,0)),"^"),ORN=$G(^SC(+JJ,0))
 I +JJ S ^TMP("CSLSUR1",$J,9)=JJ_"^"_$P(ORN,"^")
AR10 ; SPD Comments
 S L=0 F  S L=$O(^SRF(SRTN,80,L)) Q:'L  S X=$G(^SRF(SRTN,80,L,0)) D
 .S ^TMP("CSLSUR1",$J,10,L)=X
AR11 ; Hospital
 S SPF=$P($G(^SRO(133,+$$SITE^SROUTL0(SRTN),0)),"^")
 I +SPF S ^TMP("CSLSUR1",$J,11)=SPF_"^"_$$GET1^DIQ(4,+SPF,.01)
AR12 ; Scheduled by
 S SRSP=$P($G(^SRF(SRTN,"1.0")),"^",10)
 I +SRSP S ^TMP("CSLSUR1",$J,12)=SRSP_"^"_$P($G(^VA(200,+SRSP,0)),"^")
AR13 ; Entered by
 S ^TMP("CSLSUR1",$J,13)=DUZ_"^"_$P($G(^VA(200,+DUZ,0)),"^")
AR14 ; IN/OUT-PATIENT STATUS  
 I $P(SRNODE0,"^",12)'="" S ^TMP("CSLSUR1",$J,14)=$P(SRNODE0,"^",12)
AR15 ; Time Stamp
 D NOW^%DTC S ^TMP("CSLSUR1",$J,15)=%
AR16 ; Attending Surgeon
 S ASURG=$P($G(^SRF(SRTN,.1)),"^",13)
 I +ASURG S ^TMP("CSLSUR1",$J,16)=ASURG_"^"_$P($G(^VA(200,+ASURG,0)),"^")
 ;
SEND ; Call CoreFLS API
 S DYNOTE=+$$BLDSEG^CSLSUR1(1)
 I '$P(SRNODE31,"^",10) S $P(^SRF(SRTN,31),"^",10)=$S(DYNOTE=1:1,1:0)
 S SROP=SRTN,SROPER="" D ^SROP1 I SROPER["REQUESTED" S $P(^SRF(SRTN,31),"^",10)=0
EXIT K ^TMP("CSLSUR1",$J)
 Q
CHKS(SRDA) ; Calculate checksum of SPD COMMENTS field
 N J,L,X,SRCSUM S SRCSUM=0
 S L=0 F  S L=$O(^SRF(SRDA,80,L)) Q:'L  S X=^SRF(SRDA,80,L,0) F J=1:1:$L(X) S SRCSUM=L*J*$A(X,J)+SRCSUM
 Q SRCSUM
