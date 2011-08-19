ORWDAL32 ; SLC/REV - Allergy calls to support windows ;5/31/05  14:14
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,109,190,195,233,243**;Dec 17, 1997;Build 242
 ;
DEF(LST) ; Get dialog data for allergies
 N ILST,I,X S ILST=0
 S LST($$NXT)="~Allergy Types" D ALLGYTYP
 S LST($$NXT)="~Reactions" D ALLGYTYP
 S LST($$NXT)="~Nature of Reaction" D NATREACT
 S LST($$NXT)="~Top Ten" D TOPTEN
 S LST($$NXT)="~Observ/Hist" D OBSHIST
 S LST($$NXT)="~Severity" D SEVERITY
 Q
GMRASITE(ORY) ;Return GMRA Site Params
 N GMRASITE
 D SITE^GMRAUTL
 S ORY=$G(^GMRD(120.84,GMRASITE,0))
 Q
TOPTEN ;  Get top ten symptoms from Allergy Site Parameters file
 N X0,I,CNT,GMRASITE S I=0,X0="",CNT=0 ;233
 D SITE^GMRAUTL ;233
 F  S I=$O(^GMRD(120.84,GMRASITE,1,I)),CNT=CNT+1 Q:+I=0!(CNT>10)  D  ;233
 . S X0=^GMRD(120.84,GMRASITE,1,I,0) Q:'$D(^GMRD(120.83,X0))  Q:$P(^GMRD(120.83,X0,0),"^")="OTHER REACTION"  ;233 Don't send this entry
 . ;233 Don't send if inactive term
 . I $L($T(SCREEN^XTID)) Q:$$SCREEN^XTID(120.83,.01,X0_",")
 . S LST($$NXT)="i"_X0_U_$P($G(^GMRD(120.83,X0,0)),U,1)
 Q
ALLSRCH(Y,X) ; Return list of partial matches  ; CHANGED TO PRODUCE TREEVIEW IN GUI
 N ORX,ROOT,XP,CNT,ORFILE,ORSRC,ORIEN,ORREAX S ORIEN=0,CNT=0,ORSRC=0,ORFILE=""
 S ORX=X,X=$$UP^XLFSTR(X)
 F ROOT="^GMRD(120.82,""B"")","^GMRD(120.82,""D"")",$$B^PSNAPIS,$$T^PSNAPIS,"^PSDRUG(""B"")","^PSDRUG(""C"")","^PS(50.416,""P"")","^PS(50.605,""C"")" D
 . S ORSRC=$G(ORSRC)+1,ORFILE=$P(ROOT,",",1)_")",ORSRC(ORSRC)=$P($T(FILENAME+ORSRC),";;",2)
 . I (ORSRC'=2),(ORSRC'=6) S CNT=CNT+1,Y(CNT)=ORSRC_U_ORSRC(ORSRC)_U_U_U_"TOP"_U_"+"
 . I ORSRC=1!(ORSRC=2) D
 .. I $D(@ROOT@(X)) D
 ... I ORSRC=1,X="OTHER ALLERGY/ADVERSE REACTION" Q  ;don't send this entry
 ... S ORIEN=$O(@ROOT@(X,0))
 ... I $L($T(SCREEN^XTID)) I $$SCREEN^XTID(120.82,.01,ORIEN_",") Q  ;233 Is term active?
 ... I ORSRC=2 S CNT=CNT+1,Y(CNT)=ORIEN_U_$P($G(^GMRD(120.82,+ORIEN,0)),U,1)_" <"_X_">"_ROOT
 ... I ORSRC'=2  S CNT=CNT+1,Y(CNT)=ORIEN_U_X_ROOT
 ... S Y(CNT)=Y(CNT)_U_$P($G(^GMRD(120.82,+Y(CNT),0)),U,2)_U_$S(ORSRC=2:1,1:ORSRC)
 .. S XP=X F  S XP=$O(@ROOT@(XP)) Q:XP=""  Q:$E(XP,1,$L(X))'=X  D
 ... I ORSRC=1,XP="OTHER ALLERGY/ADVERSE REACTION" Q  ;don't send this entry
 ... S ORIEN=$O(@ROOT@(XP,0))
 ... I $L($T(SCREEN^XTID)) I $$SCREEN^XTID(120.82,.01,ORIEN_",") Q  ;233 Is term active?
 ... I ORSRC=2 S CNT=CNT+1,Y(CNT)=ORIEN_U_$P($G(^GMRD(120.82,+ORIEN,0)),U,1)_" <"_XP_">"_ROOT ; partial matches
 ... I ORSRC'=2  S CNT=CNT+1,Y(CNT)=ORIEN_U_XP_ROOT
 ... S Y(CNT)=Y(CNT)_U_$P($G(^GMRD(120.82,+Y(CNT),0)),U,2)_U_$S(ORSRC=2:1,1:ORSRC)
 . I (ORSRC>2),(ORSRC'=4),(ORSRC'=5),(ORSRC'=6) D
 .. N CODE,LIST,VAL,NAME
 .. S CODE=$S(ORSRC=3:"S VAL=$$TGTOG2^PSNAPIS(X,.LIST)",ORSRC=4:"D TRDNAME(X,.LIST)",ORSRC=7:"D INGSRCH(X,.LIST)",ORSRC=8:"D CLASRCH(X,.LIST)",1:"") Q:'$L(CODE)
 .. X CODE I $D(LIST) S ORIEN=0 F  S ORIEN=$O(LIST(ORIEN)) Q:'ORIEN  D
 ... S NAME=$P(LIST(ORIEN),U,2)
 ... Q:$E($P(LIST(ORIEN),U,2),1,$L(X))'=X
 ... I $L($T(SCREEN^XTID)) I $$SCREEN^XTID($S(ORSRC=3:50.6,(ORSRC=4):50.6,ORSRC=7:50.416,ORSRC=8:50.605,1:0),.01,ORIEN_",") Q
 ... S CNT=CNT+1,Y(CNT)=ORIEN_U_NAME_ROOT_U_"D"_U_ORSRC
 . I ORSRC=4 D
 .. N CODE,LIST,VAL,NAME
 .. S CODE="D TRDNAME(X,.LIST)"
 .. X CODE I $D(LIST) S ORIEN=0 F  S ORIEN=$O(LIST(ORIEN)) Q:'ORIEN  D
 ... S NAME=$P(LIST(ORIEN),U,2)
 ... Q:$E($P(LIST(ORIEN),U,2),1,$L(X))'=X
 ... I $L($T(SCREEN^XTID)) I $$SCREEN^XTID(50.6,.01,+LIST(ORIEN)_",") Q
 ... S CNT=CNT+1,Y(CNT)=+LIST(ORIEN)_U_NAME_ROOT_U_"D"_U_ORSRC
 Q
FILENAME ; Display text of filenames for search treeview
 ;;VA Allergies File
 ;;VA Allergies File (Synonyms)  SPACER ONLY - NOT DISPLAYED
 ;;National Drug File - Generic Drug Name
 ;;National Drug file - Trade Name
 ;;Local Drug File
 ;;Local Drug File (Synonyms)  SPACER ONLY - NOT DISPLAYED
 ;;Drug Ingredients File
 ;;VA Drug Class File
 ;;
NATREACT ; Get the NATURE OF REACTION types
 ;Removing "R^Adverse Reaction" from choices below until we can add it as a choice in the nature of reaction/mechanism file
 F X="A^Allergy","P^Pharmacological","U^Unknown" D
 . S LST($$NXT)="i"_X
 Q
ALLGYTYP ; Get the allergy types
 F X="D^Drug","F^Food","O^Other","DF^Drug,Food","DO^Drug,Other","FO^Food,Other","DFO^Drug,Food,Other" D
 . S LST($$NXT)="i"_X
 Q
OBSHIST ; Observed or historical
 F X="o^Observed","h^Historical" D
 . S LST($$NXT)="i"_X
 Q
SEVERITY ; Severity
 F X="3^Severe","2^Moderate","1^Mild" D
 . S LST($$NXT)="i"_X
 Q
SYMPTOMS(Y,FROM,DIR) ; Return a subset of symptoms
 ; .Return Array, Starting Text, Direction
 N I,IEN,CNT,X,NAME,SUB S I=0,CNT=44 ;233
 K ^TMP($J,"SIGNS") ;233
 ;The following lines were added in 233.  Now accounts for synonyms
 M ^TMP($J,"SIGNS","B")=^GMRD(120.83,"B") ;233
 S SYN="" F  S SYN=$O(^GMRD(120.83,"D",SYN)) Q:SYN=""  S SUB=0 F  S SUB=$O(^GMRD(120.83,"D",SYN,SUB)) Q:'+SUB  D  ;233
 .S NAME=$P(^GMRD(120.83,SUB,0),U) S ^TMP($J,"SIGNS","B",(SYN_$C(9)_"<"_NAME_">"_U_NAME),SUB)="" ;233
 F  Q:I'<CNT  S FROM=$O(^TMP($J,"SIGNS","B",FROM),DIR) Q:FROM=""  D  ;233
 . I FROM="OTHER REACTION" Q  ;Don't send this entry
 . S IEN=0 F  S IEN=$O(^TMP($J,"SIGNS","B",FROM,IEN)) Q:'IEN  D  ;233
 . . I $L($T(SCREEN^XTID)) I $$SCREEN^XTID(120.83,.01,IEN_",") Q  ;233 Is term active
 . . S I=I+1
 . . S Y(I)=IEN_U_FROM
 Q
NXT() ; Increment index of LST
 S ILST=ILST+1
 Q ILST
EDITLOAD(Y,ORALIEN) ; Load an allergy/adverse reaction for editing
 Q:+$G(ORALIEN)=0
 N ORNODE,I
 S ORNODE=$NAME(^TMP("GMRA",$J)),I=0
 ;following patch check is made via GUI RPC call to ORWU PATCH instead
 ;I '$$PATCH^XPDUTL("GMRA*4.0*21") S @ORNODE@(0)="-1^Not yet implemented",Y=ORNODE Q
 D GETREC^GMRAGUI(ORALIEN,ORNODE)
 S Y=ORNODE
 Q
EDITSAVE(ORY,ORALIEN,ORDFN,OREDITED) ; Save Edit/Add of an allergy/adverse reaction
 ;following patch check is made via GUI RPC call to ORWU PATCH instead
 ;I '$$PATCH^XPDUTL("GMRA*4.0*21") S Y="-1^Not yet implemented" Q
 N ORNODE
 S ORNODE=$NAME(^TMP("GMRA",$J))
 K @ORNODE M @ORNODE=OREDITED
 S ORY=0
 I $G(@ORNODE@("GMRAERR"))="YES" D EIE^GMRAGUI1(ORALIEN,ORDFN,ORNODE) Q  ;Handle entered in error
 I $G(@ORNODE@("GMRANKA"))="YES" D NKA^GMRAGUI1 Q
 D UPDATE^GMRAGUI1(ORALIEN,ORDFN,ORNODE) Q  ;Add/edit reactions
 Q
SENDBULL(Y,ORDUZ,ORDFN,ORTEXT,ORCMTS) ; Send bulletin if user attempts free-text entry
 I '$D(ORCMTS) D
 . S Y=$$SENDREQ^GMRAPES0(ORDUZ,ORDFN,ORTEXT)
 E  D
 . S Y=$$SENDREQ^GMRAPES0(ORDUZ,ORDFN,ORTEXT,.ORCMTS)
 Q
INGSRCH(NAME,LIST) ;
 K ^TMP($J,"ORWDAL32")
 D NAME^PSN50P41(NAME,"ORWDAL32")
 I $D(^TMP($J,"ORWDAL32","P")) D
 . N I S I="" F  S I=$O(^TMP($J,"ORWDAL32","P",I)) Q:I=""  D
 .. N J S J=0 F  S J=$O(^TMP($J,"ORWDAL32","P",I,J)) Q:'J  S LIST(J)=J_U_I
 K ^TMP($J,"ORWDAL32")
 Q
CLASRCH(NAME,LIST) ;
 K ^TMP($J,"ORWDAL32")
 D C^PSN50P65(,NAME,"ORWDAL32")
 I $D(^TMP($J,"ORWDAL32","C")) D
 . N I S I="" F  S I=$O(^TMP($J,"ORWDAL32","C",I)) Q:I=""  D
 .. N J S J=0 F  S J=$O(^TMP($J,"ORWDAL32","C",I,J)) Q:'J  S LIST(J)=J_U_$G(^TMP($J,"ORWDAL32",J,1))
 K ^TMP($J,"ORWDAL32")
 Q
TRDNAME(NAME,LIST) ;
 K ^TMP($J,"ORWDAL32")
 D ALL^PSN5067(,NAME,,"ORWDAL32")
 I $D(^TMP($J,"ORWDAL32","B")) D
 . N I S I="" F  S I=$O(^TMP($J,"ORWDAL32","B",I)) Q:I=""  D
 .. N J,K S J=$O(^TMP($J,"ORWDAL32","B",I,0)) Q:'J  S K=$$TGTOG^PSNAPIS(I),LIST(J)=K_U_$G(^TMP($J,"ORWDAL32",J,4))
 K ^TMP($J,"ORWDAL32")
 Q
