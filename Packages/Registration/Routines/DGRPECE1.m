DGRPECE1 ;ALB/MRY - REGISTRATION CATASTROPHIC EDITS ALERT ; 11/17/04 9:30am
 ;;5.3;Registration;**638,831**;Aug 13, 1993;Build 10
 ;
ALERT ;setup alert, display
 K XQA,XQAMSG,XQAROU,XQAARCH,XQAID,XQADATA
 N DGSITE,DGDUZ,CNT,DGI
 ;XQA builds alert array.  XMY builds mailgroup array (if needed).
 S DGDUZ=0 F  S DGDUZ=$O(^XUSEC("DG CATASTROPHIC EDIT",DGDUZ)) Q:'DGDUZ  S XQA(DGDUZ)=""
 I $O(XQA(""))="" D
 . S DGDUZ=0 F  S DGDUZ=$O(^XUSEC("DG SUPERVISOR",DGDUZ)) Q:'DGDUZ  S XQA(DGDUZ)="",XMY(DGDUZ)=""
 . S XMY("G.MPIF EXCEPTIONS")=""
 . D MSG
 I $O(XQA(""))="" Q  ;hard to believe no supervisors.
 S XQAMSG="POTENTIAL CATASTROPHIC EDIT OF PATIENT IDENTIFYING DATA"
 ;see below for XQADATA values
 S CNT=0 F DGI="NAME","SSN","DOB","SEX","MAIDEN","POBCITY","POBSTATE" S CNT=CNT+1 I $D(BEFORE(DGI)) S $P(XQADATA,U,CNT)=BEFORE(DGI)
 S CNT=7 F DGI="NAME","SSN","DOB","SEX" S CNT=CNT+1 I $D(BUFFER(DGI)) S $P(XQADATA,U,CNT)=BUFFER(DGI) I $D(SAVE(DGI)) S $P(XQADATA,U,CNT)=$P(XQADATA,U,CNT)_";*"
 S $P(XQADATA,U,12)=IEN,DGSITE=$$SITE^VASITE(),DGSITE=$P(DGSITE,U,3)
 S $P(XQADATA,U,13)=DGSITE,$P(XQADATA,U,14)=XQY ;XQY = users current option (pointer)
 S XQAROU="DISP^DGRPECE1",XQAARCH=365
 S XQAID="DG,"_IEN
 D SETUP^XQALERT Q
 ;
DISP ;display catastrophic alert information
 N DGNAME,DGIEN,DGDATA,Y,HDR,HDR1,HDR2,DGRFLG
 K XQAKILL ; Keep alert, unless removed (XQAKILL=1 below)
 S DGIEN=$O(^XTV(8992.1,"B",XQAID,""))
 W @IOF ;W !!,$TR($J("",IOM)," ","=")
 S HDR=" <POTENTIAL CATASTROPHIC EDIT OF PATIENT IDENTIFYING DATA> "
 S HDR1=$TR($J("",(IOM/2-($L(HDR)/2)))," ","=")_HDR,HDR2=HDR1_$TR($J("",(IOM-$L(HDR1)))," ","=")
 W !,HDR2 ;W !,?(IOM-$L(HDR)/2),HDR
 S DGNAME=$P($P(XQADATA,U,8),";")
 W !,"Patient: ",DGNAME_" (ICN:"_$$GETICN^MPIF001($P(XQADATA,U,12))_")",?60,"Station: ",$P(XQADATA,U,13)
 W !,$TR($J("",IOM)," ","-")
 W !,"Patient Identification fields (before edit)"
 W !,$TR($J("",IOM)," ","-")
 W !?1,"Name: ",$P(XQADATA,U),?45,"Soc. Security Number: ",$P(XQADATA,U,2)
 W !?1,"Date of Birth: ",$$DATE4($P(XQADATA,U,3)),?45,"Gender: ",$S($P(XQADATA,U,4)="M":"MALE",$P(XQADATA,U,4)="F":"FEMALE",1:$P(XQADATA,U,4))
 W !?1,"Mother's Maiden Name: ",$P(XQADATA,U,5)
 W !?1,"Place of Birth [city]: ",$P(XQADATA,U,6)
 W !?1,"Place of Birth [state]: " I $P(XQADATA,U,7) W $P(^DIC(5,$P(XQADATA,U,7),0),U)
 W !,$TR($J("",IOM)," ","-")
 W !,"Patient Identification fields (after edit)"
 W !,$TR($J("",IOM)," ","-")
 W ! W:$P($P(XQADATA,U,8),";",2)="*" "*" W ?1,"Name: ",$P($P(XQADATA,U,8),";") W ?44 W:$P($P(XQADATA,U,9),";",2)="*" "*" W ?45,"Soc. Security Number: ",$P($P(XQADATA,U,9),";")
 W ! W:$P($P(XQADATA,U,10),";",2)="*" "*" W ?1,"Date of Birth: ",$$DATE4($P($P(XQADATA,U,10),";"))
 W ?44 W:$P($P(XQADATA,U,11),";",2)="*" "*" W ?45,"Gender: ",$S($P($P(XQADATA,U,11),";")="M":"MALE",$P($P(XQADATA,U,11),";")="F":"FEMALE",1:"")
 W !,$TR($J("",IOM)," ","-")
 S DGDATA=$$GET1^DIQ(8992.1,+DGIEN_",",.02)
 W !,"Edited by:   ",$$GET1^DIQ(8992.1,+DGIEN_",",.05),?45,"Generated: ",$$FMTE^XLFDT(DGDATA,"2P")
 S DGDATA=$P(XQADATA,U,14),DGDATA=$$GET1^DIQ(19,+DGDATA_",",.01) ;option name
 W !,"With Option: ",DGDATA
 ;W !,$TR($J("",IOM)," ","-")
 S DGDATA=$$GET1^DIQ(8992.1,+DGIEN_",",2)
 W !,"Reviewed by: " W:$P(DGDATA,U,15) $P(^VA(200,$P(DGDATA,U,15),0),U)
 W:$P(DGDATA,U,15) ?45,"Catastrophic Edit: ",$S($P(DGDATA,U,16)=1:"YES",1:"NO")
 W !,$TR($J("",IOM)," ","-")
 ;CE reviewed?
 S DGRFLG=0 ;Review flag determine delete prompting
 I $P(DGDATA,U,15)="" D REVIEW S DGRFLG=1
 ;If CE reviewed, can the alert be removed?
 I $P(DGDATA,U,15) D REMOVE
 K XQAKILL
 Q
 ;
REVIEW ;
 N DGANS,DIR,DGCE
 S DIR(0)="Y",DIR("A")="IS REVIEW COMPLETE"
 S DIR("B")="NO" D ^DIR K DIR S DGANS=Y
 I DGANS=1 D
 . S DIR(0)="Y",DIR("A")="IS THIS ALERT DETERMINED TO BE A CATASTROPHIC EDIT"
 . S DIR("B")="NO" D ^DIR K DIR S DGCE=Y
 . N FDA
 . S $P(DGDATA,U,15)=DUZ
 . S $P(DGDATA,U,16)=DGCE
 . S FDA(8992.1,+DGIEN_",",2)=DGDATA
 . D FILE^DIE("","FDA","DIERR")
 Q
REMOVE ;
 N Y,DIR
 S DIR(0)="Y"
 S:DGRFLG=1 DIR("A")="DO YOU WANT TO DELETE ALERT"
 S:DGRFLG=0 DIR("A")="THIS ALERT HAS BEEN REVIEWED, DO YOU WANT TO DELETE THE ALERT"
 S DIR("B")="NO" D ^DIR K DIR
 I Y=1 S XQAKILL=1 D DELETE^XQALERT ;keep renewed, unless reviewed
 Q
MSG ;
 K ^TMP($J,"DGRPECE")
 S XMDUZ=.5,XMSUB="POTENTIAL CATASTROPHIC EDIT ALERT SETUP"
 S ^TMP($J,"DGRPECE",1,0)="ATTENTION ADT SUPERVISORS:"
 S ^TMP($J,"DGRPECE",2,0)=" "
 S ^TMP($J,"DGRPECE",3,0)="You are receiving this message along with a potential catastrophic edit alert"
 S ^TMP($J,"DGRPECE",4,0)="because there are no users holding the DG CATASTROPHIC EDIT key."
 S ^TMP($J,"DGRPECE",5,0)=" "
 S ^TMP($J,"DGRPECE",6,0)="Please see that an appropriate Supervisor and ADPAC are given this key."
 S ^TMP($J,"DGRPECE",7,0)="Documentation on these catastrophic edits can be found in patch DG*5.3*638."
 S ^TMP($J,"DGRPECE",8,0)=" "
 S ^TMP($J,"DGRPECE",9,0)="This message has been forwarded to the National Data Quality mailgroup."
 S ^TMP($J,"DGRPECE",10,0)="Station name: "_$P($$SITE^VASITE(),U,2)_" ("_$P($$SITE^VASITE(),U)_")"
 S XMTEXT="^TMP("_$J_",""DGRPECE""," D ^XMD S DA=XMZ,DIE=3.9,DR="1.7///P;1.97///Y" D ^DIE
 K ^TMP($J,"DGRPECE"),DIE,DA,DR,XMY,XMDUZ,XMSUB,XMTEXT,XMZ Q
DATE4(X) ;return date in DD/MM/YYYY format
 I X'["/" D
 .S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3))
 Q X
 ;
XQADATA ;XQADATA =
 ;1=before snapshot name^                  (31 chars = 30 chars+'^')
 ;2=before snapshot ssn^                   (11)
 ;3=before snapshot dob^                   ( 8)
 ;4=before snapshot sex^                   ( 2)
 ;5=before snapshot mother's maiden name^  (18)
 ;6=before snapshot pob city^              (16)
 ;7=before snapshot pob state^             ( 3) a guess, its a pointer
 ;8=after snapshot name^                   (31)
 ;9=after snapshot ssn^                    (11)
 ;10=after snapshot dob^                   ( 8)
 ;11=after snapshot sex^                   ( 2)
 ;12=patient ien^                          (11) a guess, its a pointer
 ;13=station#^                             ( 6) a guess, its a pointer
 ;14=user menu pointer^                    ( 5) a guess, its a pointer
 ;15=reviewer duz^                         (11) a guess, its a pointer
 ;16=CE edit (y/n)                         ( 2)
 ;                                 total = 176 chars.
