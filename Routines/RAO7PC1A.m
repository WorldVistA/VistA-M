RAO7PC1A ;HISC/GJC-Procedure Call utilities (cont) ;1/22/03  12:41
 ;;5.0;Radiology/Nuclear Medicine;**1,10,26,31,36,45,56**;Mar 16, 1998;Build 3
 ;Supported IA #10040 ^SC(
 ;Supported IA #10103 DT^XLFDT, FMADD^XLFDT
 ;Supported IA #2056 GET1^DIQ
 ;Supported IA #10104 LOW^XLFSTR, UP^XLFSTR
SETDATA ; Called from within the EN1 subroutine of RAO7PC1
 ; Sets the ^TMP($J,"RAE1",patient ien,Exam ID) node.
 ; See EN1^RAO7PC1 for further explanation.
 ;
 ; Output (new) :
 ; ^TMP($J,"RAE1",Patient IEN,Exam ID,"CMOD",1)=cptmod^cptmodname
 ;                                          ,2)=cptmod^cptmodname
 N RA,RA1,RA2,RA3
 S RANO=0,RAREX(0)=$G(^RADPT(RADFN,"DT",RAIBDT,0))
 S RAITY=+$P(RAREX(0),"^",2),RAILOC=+$P(RAREX(0),"^",4)
 S RAILOC=$P($G(^SC(+$P($G(^RA(79.1,RAILOC,0)),"^"),0)),"^")
 S RAITY(0)=$G(^RA(79.2,RAITY,0))
 F  S RANO=$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO)) Q:RANO'>0  D  Q:RAXIT
 . S RAXAM(0)=$G(^RADPT(RADFN,"DT",RAIBDT,"P",RANO,0))
 . Q:RAXAM(0)=""
 . S RAORDER=+$P(RAXAM(0),"^",11)
 . ; quit if exam is WAITING and its order status isn't ACTIVE
 . ; because this means exam hasn't finished being registered
 . I $P($G(^RA(72,+$P(RAXAM(0),U,3),0)),U,3)=1,$P($G(^RAO(75.1,RAORDER,0)),U,5)'=6 Q
 . S RAORDER(7)=$P($G(^RAO(75.1,RAORDER,0)),"^",7) ; CPRS order ien
 . S RAXSTAT=+$P(RAXAM(0),"^",3),RAXSTAT(0)=$G(^RA(72,RAXSTAT,0))
 . S RAXID=RAIBDT_"-"_RANO
 . S RACSE=$S($P(RAXAM(0),U)]"":$P(RAXAM(0),U),1:"Unknown")
 . S RAPRC=$G(^RAMIS(71,+$P(RAXAM(0),U,2),0))
 . S RACPT=+$P(RAPRC,"^",9) ; pntr to 81
 . S RACPT=$$NAMCODE^RACPTMSC(RACPT,DT)
 . S RACPT=$S($P(RACPT,"^",2)]"":$P(RACPT,"^"),1:"")
 . S RAPRC=$S($P(RAPRC,U)]"":$P(RAPRC,U),1:"Unknown")
 . ; quit if cancelled exam, and cancelled exams not requested
 . I ('$G(RACINC)),($P($G(^RA(72,+$P(RAXAM(0),"^",3),0)),"^",3)=0) Q
 . S RADIAG=+$P(RAXAM(0),U,13),RARPT=+$P(RAXAM(0),U,17)
 .; E3R 17541, 15507
 .; if want cancel'd cases returned, and this case is cancelled, then
 .; also require div param ALLOW RPTS ON CANCELLED CASES? = Y and
 .; presence of report, else skip this case
 . I $G(RACINC),($P($G(^RA(72,+$P(RAXAM(0),"^",3),0)),"^",3)=0) D  Q:RASHOCAN=0
 .. S RASHOCAN=0
 .. I $P($G(^RA(79,+$P(RAREX(0),"^",3),.1)),"^",22)="Y",RARPT S RASHOCAN=1
 .. Q
 . S RABNOR=$$UP^XLFSTR($P($G(^RA(78.3,RADIAG,0)),U,4))
 . S:RABNOR'="Y" RABNOR=""
 . S RABNORMR=$$UP^XLFSTR($P($G(^RA(78.3,RADIAG,0)),U,3))
 . S:RABNORMR'="Y" RABNORMR=""
 . S RARPTST=$$RSTAT(),RARPTST=$$UL(RARPTST)
 . S ^TMP($J,"RAE1",RADFN,RAXID)=RAPRC_U_RACSE_U_RARPTST_U_RABNOR_U_$S(RARPT=0:"",1:RARPT)_U_$P(RAXSTAT(0),"^",3)_"~"_$P(RAXSTAT(0),"^")_U_RAILOC_U_$P(RAITY(0),"^",3)_"~"_$P(RAITY(0),"^")_U_RABNORMR_U_RACPT_U_$G(RAORDER(7))
 . S ^TMP($J,"RAE1",RADFN,RAXID)=^TMP($J,"RAE1",RADFN,RAXID)_U_$S($O(^RARPT(RARPT,2005,0)):"Y",1:"N")
 . D CPTMOD
 . S RACNT=RACNT+1
 .;
 .; Condensed Radiology Display in CPRS GUI:
 .; subtract from count if counting parent; count only 1 case from printset
 .; and
 .; store values of MEMBER OF SET and ordered parent procedure name
 . I $D(RAEXNP),$E(RAEXNP,$L(RAEXNP))="P" D
 .. I $P(RAXAM(0),U,25)="2",$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO),-1) S RACNT=RACNT-1
 .. I $P(RAXAM(0),U,25) D
 ... S RA3=$S('RAORDER:"",1:$P($G(^RAMIS(71,+$P($G(^RAO(75.1,+RAORDER,0)),U,2),0)),U))
 ... S RA3=$S(RA3'="":RA3,1:"PARENT PROCEDURE")
 ... S ^TMP($J,"RAE1",RADFN,RAXID,"CPRS")=$P(RAXAM(0),U,25)_U_RA3
 ... Q
 .. Q
 . S:RACNT=RAEXN RAXIT=1
 .; Condensed Radiology Display in CPRS GUI:
 .; do not exit until all cases of printset have been stored
 . I $D(RAEXNP),$E(RAEXNP,$L(RAEXNP))="P",$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO)) S RAXIT=0
 . K RAXSTAT,RAORDER
 . Q
 K RAILOC,RAITY
 Q
CASE ; Return the case numbers and the total number of case numbers
 ; associated with a particular order.  Called from CASE^RAO7PC1.
 ; Sets RARRAY(case #)="" for all cases associated with an order.
 ; Sets first piece of RATTL to the number of cases found for an
 ; order, and the second piece is PRINTSET if the report covers
 ; multiple cases.  See CASE^RAO7PC1 for more information.
 I '$D(^RAO(75.1,RAOIFN,0))#2 S RATTL="-1^invalid order ien" Q
 I '$D(^RADPT("AO",RAOIFN)) D  Q  ; case has yet to be registered
 . S RATTL="-2^no case registered to date"
 . Q
 N RACNI,RADFN,RADTI,RAEXAM S RADFN=0
 F  S RADFN=$O(^RADPT("AO",RAOIFN,RADFN)) Q:RADFN'>0  D
 . S RADTI=0
 . F  S RADTI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI)) Q:RADTI'>0  D
 .. S RACNI=0
 .. F  S RACNI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RACNI)) Q:RACNI'>0  D
 ... S RAEXAM=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ... Q:$P($G(^RA(72,+$P(RAEXAM,"^",3),0)),"^",3)=0  ; xam cancelled
 ... S RATTL=+$G(RATTL)+1,@(RARRAY_"("_+RAEXAM_")")=""
 ... Q
 .. Q
 . Q
 I 'RATTL S RATTL="-2^cases cancelled" Q
 S:$P(RAEXAM,"^",25)=2 RATTL=RATTL_"^PRINTSET" ; combined reports
 Q
 ;
EN2 ; IA: 2012, Return last 7 days of non-cancelled exams
 ; Required: RADFN (valid patient ien) called from EN2^RAO7PC1
 ; Output:
 ; ^TMP($J,"RAE7",Patient IEN,Exam ID)=procedure name^case number^
 ;       report status^imaging location IEN^imaging location name^
 ;       contrast medium or media used
 ;       Note: Single characters in parenthesis indicate contrast
 ;       involvement: (I)=Iodinated ionic; (N)=Iodinated non-ionic;
 ;        (L)=Gadolinium; (C)=Oral Cholecystographic; (G)=Gastrografin;
 ;        (B)=Barium; (M)=unspecified contrast media
 ;
 ; Exam ID: exam date/time (inverse) concatenated with the case IEN
 ;
 Q:'$D(RADFN)  Q:'RADFN  K ^TMP($J,"RAE7")
 N I,RABDT,RACNST,RACSE,RADT,RAEDT,RAIBDT,RAIEDT,RALOC,RACMEDIA,RANO
 N RAPRC,RAREX,RARPT,RARPTST,RAXAM,RAXID,RAXSTAT
 S RADT=$S($D(DT)#2:DT,1:$$DT^XLFDT()),RACNST=9999999.9999
 S RABDT=$$FMADD^XLFDT(RADT,-7,0,0,0),RAEDT=RADT
 S RAIBDT=RACNST-(RAEDT+.9999),RAIEDT=RACNST-(RABDT-.0001)
 F  S RAIBDT=$O(^RADPT(RADFN,"DT",RAIBDT)) Q:RAIBDT'>0!(RAIBDT>RAIEDT)  D
 . S RANO=0,RAREX(0)=$G(^RADPT(RADFN,"DT",RAIBDT,0))
 . S RALOC=+$P(RAREX(0),U,4),RALOC(0)=$G(^RA(79.1,RALOC,0))
 . S RALOC=$P($G(^SC(+RALOC(0),0)),"^")
 . F  S RANO=$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO)) Q:RANO'>0  D
 .. S RAXAM(0)=$G(^RADPT(RADFN,"DT",RAIBDT,"P",RANO,0))
 .. S RAXID=RAIBDT_"-"_RANO
 .. S RACSE=$S($P(RAXAM(0),U)]"":$P(RAXAM(0),U),1:"Unknown")
 .. S RAPRC=$G(^RAMIS(71,+$P(RAXAM(0),U,2),0))
 .. S RAPRC=$S($P(RAPRC,U)]"":$P(RAPRC,U),1:"Unknown")
 .. Q:$P($G(^RA(72,+$P(RAXAM(0),"^",3),0)),"^",3)=0  ; cancelled xam
 .. S I=0,RACMEDIA="" F  S I=$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO,"CM",I)) Q:'I  S RACMEDIA=RACMEDIA_$P(^(I,0),U) ;RA*5*45
 .. S RARPT=+$P(RAXAM(0),U,17)
 .. S RARPTST=$$RSTAT(),RARPTST=$$UL(RARPTST)
 .. S ^TMP($J,"RAE7",RADFN,RAXID)=RAPRC_U_RACSE_U_RARPTST_U_+RALOC(0)_U_RALOC_U_RACMEDIA
 .. Q
 . Q
 Q
CPTMOD ;extract cpt modifiers if any
 ;RA loop var, RA1 counter, RA2 intermed vars
 Q:'$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO,"CMOD",0))
 S RA=0,RA1=1
 F  S RA=$O(^RADPT(RADFN,"DT",RAIBDT,"P",RANO,"CMOD",RA)) Q:'RA  I $D(^(RA,0)) D
 . S RA2=$P(^RADPT(RADFN,"DT",RAIBDT,"P",RANO,"CMOD",RA,0),"^")
 . S RA2=$$BASICMOD^RACPTMSC(RA2,+RAREX(0)) Q:+RA2<0
 . S ^TMP($J,"RAE1",RADFN,RAXID,"CMOD",RA1)=$P(RA2,"^",2)_"^"_$P(RA2,"^",3),RA1=RA1+1
 Q
RSTAT() ; Get report status name from GET1^DIQ
 ; RARPT is IEN of file 74
 N R,DIERR
 S R=$S($G(RARPT)>0:$$GET1^DIQ(74,+RARPT,5),1:"")
 S:R="" R="NO REPORT"
 Q R
UL(R) ;Upper and Lower case
 ;First convert all chars to lower case, then
 ;capitalize 1st char AND (char after /  OR  char after blank)
 N L,R2
 S R2=$E(R,1)_$$LOW^XLFSTR($E(R,2,$L(R))) ; 1st char must be in caps
 S L=$F(R2,"/") ; If str has /, cap char after / but not char after blank
 I L S R2=$E(R2,1,L-1)_$$UP^XLFSTR($E(R2,L))_$E(R2,L+1,$L(R2)) G UPQ
 S L=$F(R2," ") ; If str has one blank, then cap the char after the blank
 I L S R2=$E(R2,1,L-1)_$$UP^XLFSTR($E(R2,L))_$E(R2,L+1,$L(R2))
UPQ Q R2
