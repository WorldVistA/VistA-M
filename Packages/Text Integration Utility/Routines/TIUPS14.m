TIUPS14 ; SLC/JER - Post-Install for TIU*1*4;Dec 05, 1997 08:30 ;2/3/98@09:52:05
 ;;1.0;Text Integration Utilities;**4**;Jun 20, 1997
MAIN ; Control subroutine
 N TIUDA,TIULVL,TIULNM,TIUCONT,TIUFPRIV,TIUNEW
 I +$L($T(GET^GMRCTIU))'>0 D  Q
 . W !!,$C(7),"You must install CONSULT/REQUEST TRACKING 3.0 before",!?6,"implementing this part of patch TIU*1*4."
 S TIUFPRIV=1,TIUNEW=0,TIUDA=$$TEST
 I +TIUDA>0 D  Q:+$G(TIUCONT)'>0
 . S TIULVL=$P(TIUDA,U,2)
 . S TIULNM=$S(TIULVL="CL":"CLASS",1:"DOCUMENT CLASS")
 . W !!,"You already have a ",TIULNM," called CONSULTS under "
 . W $$CLNAME(+TIUDA),"...",!
 . W !,"The new methods and properties to support the TIU/CT interface"
 . W !,"will be MERGED with the existing data. UPLOAD HEADERS and"
 . W !,"PRINT METHODS which you have defined will NOT be overwritten.",!
 . S TIUCONT=+$$READ^TIUU("Y","  Okay to continue","NO")
 . I 'TIUCONT W !!,"Great...No harm done!",!
 . S TIUDA=+TIUDA
 I +TIUDA'>0 D  Q:+TIUDA'>0
 . W !!,"I'm going to create a new Document Definition for CONSULTS now."
 . S TIUDA=$$CREATE S:+TIUDA TIUNEW=1
 . W:+TIUDA'>0 !!,$C(7),"Couldn't create Document Definition entry for CONSULTS...",!
 D:$G(TIULVL)']"" ASK(TIUDA,.TIULVL)
 I $G(TIULVL)']"" W !!,"Great...No harm done!",! Q
 D SET(TIUDA,TIULVL)
 D INDEX(TIUDA)
 I +TIUNEW D ATTACH(TIUDA,TIULVL)
 D DONE(TIULVL)
 Q
DONE(TIULVL) ; Let the user know
 N TIUCRLF S TIUCRLF=$C(13)_$C(10)
 W !!,"Okay, I'm done...Please finish your implementation of CONSULTS by"
 W " adding any",!,$S(TIULVL="CL":"Document Classes and ",1:""),"Titles"
 W " as appropriate using the Create Document Definitions",$S(TIULVL="CL":TIUCRLF,1:" "),"Option",$S(TIULVL="CL":" ",1:TIUCRLF)
 W "under the TIUF DOCUMENT DEFINITION MGR Menu, as described in"
 W " Step #3",!,"of the Post-Installation Instructions.",!
 Q
CLNAME(TIUDA) ; Get parent class's name
 N TIUY
 S TIUY=$P($G(^TIU(8925.1,+$$DOCCLASS^TIULC1(TIUDA),0)),U)
 Q $G(TIUY)
TEST() ; Check for CONSULTS entry in Document Defintion file
 N TIUY
 S TIUY=+$O(^TIU(8925.1,"B","CONSULTS",0))
 I +TIUY S $P(TIUY,U,2)=$P($G(^TIU(8925.1,+TIUY,0)),U,4)
 Q TIUY
CREATE() ; Create a record for the CONSULTS Document Definition
 N DIC,DLAYGO,X,Y
 S (DIC,DLAYGO)="^TIU(8925.1,",DIC(0)="MXL",X="CONSULTS"
 D ^DIC
 Q +$G(Y)
ASK(TIUDA,LEVEL) ; Ascertain whether to make CONSULTS a CLASS or DC
 N TIUPRMT
 W !!,"GREAT! A new Document Definition has been created for CONSULTS."
 W !,"Next, you need to decide whether you want CONSULTS to be set up"
 W !,"as a separate CLASS (comparable to DISCHARGE SUMMARY or PROGRESS"
 W !,"NOTES), or whether you want CONSULTS defined as a DOCUMENT CLASS"
 W !,"under PROGRESS NOTES. The benefits of each strategy are outlined"
 W !,"in the POST-INSTALLATION instructions for this patch.",!
 W !,"NOTE: If you're not yet CERTAIN which strategy you want your site"
 W !,"to adopt, then quit here, and get consensus first (it's easier to"
 W !,"get permission than forgiveness, in this case)!",!
 S TIUPRMT="Define CONSULTS as a CLASS or DOCUMENT CLASS"
 S LEVEL=$$READ^TIUU("S^CL:Class;DC:Document Class",TIUPRMT)
 I $P(LEVEL,U)']"" S LEVEL="" Q
 W !!,"Okay, you've indicated that you want to make CONSULTS a "
 W $P(LEVEL,U,2),".",! S TIUPRMT="  Okay to continue"
 S TIUY=$$READ^TIUU("Y",TIUPRMT,"NO")
 I +TIUY'>0 S LEVEL=""
 E  S LEVEL=$P(LEVEL,U)
 Q
INDEX(DA) ; Call IX^DIK to re-index the CONSULTS entry
 N DIK
 S DIK="^TIU(8925.1," D IX^DIK
 Q
SET(TIUDA,LEVEL) ; Set the data in the new Document Definition record
 N TIUCLP
 S TIUCLP=$$CLPAC
 S ^TIU(8925.1,TIUDA,0)="CONSULTS^CNST^CONSULTS^"_LEVEL_"^^"_TIUCLP_"^11"
 S ^TIU(8925.1,TIUDA,1)="8925^1^2;TEXT"
 S ^TIU(8925.1,TIUDA,3)="^^0"
 S ^TIU(8925.1,TIUDA,4)="D LOOKUP^TIUPUTCN"
 S ^TIU(8925.1,TIUDA,4.1)="D POST^TIUCNSLT(DA,""INCOMPLETE"")"
 S ^TIU(8925.1,TIUDA,4.4)="D ROLLBACK^TIUCNSLT(TIUDA)"
 S ^TIU(8925.1,TIUDA,4.45)="D CHANGE^TIUCNSLT(TIUDA)"
 S ^TIU(8925.1,TIUDA,4.5)="D FOLLOWUP^TIUPUTCN(TIUREC(""#""))"
 S ^TIU(8925.1,TIUDA,4.8)="D GETPN^TIUCHLP"
 S ^TIU(8925.1,TIUDA,4.9)="D POST^TIUCNSLT(DA,""COMPLETED"")"
 S ^TIU(8925.1,TIUDA,5)="[TIU ENTER/EDIT CONSULT RESULT]"
 ; -- Don't modify PRINT METHOD if already defined --
 I '$D(^TIU(8925.1,TIUDA,6)) S ^TIU(8925.1,TIUDA,6)="D ENTRY^TIUPRCN"
 ; -- If not already specified initialize ALLOW CUSTOM HEADERS to O
 I '$D(^TIU(8925.1,TIUDA,6.1)) S ^TIU(8925.1,TIUDA,6.1)="^^^0"
 S ^TIU(8925.1,TIUDA,7)="D ENPN^TIUVSIT(.TIU,.DFN,1)"
 S ^TIU(8925.1,TIUDA,8)="S TIUASK=$$CHEKPN^TIULD(.TIU,.TIUBY)"
 ; -- Don't modify upload header, if already defined --
 I '$D(^TIU(8925.1,TIUDA,"HEAD")) D
 . S ^TIU(8925.1,TIUDA,"HEAD",0)="^8925.12A^8^8"
 . S ^TIU(8925.1,TIUDA,"HEAD",1,0)="TITLE^TITLE OF CONSULT^.01^TIUTITLE^PULMONARY CONSULT^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",2,0)="SSN^PATIENT SSN^.02^TIUSSN^555-12-1234^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",2,1)="S X=$TR(X,""-/"","""")"
 . S ^TIU(8925.1,TIUDA,"HEAD",3,0)="VISIT/EVENT DATE^VISIT/EVENT DATE^.07^TIUVDT^5/15/97@08:15^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",4,0)="AUTHOR^DICTATING PROVIDER^1202^^HOWSER,DOOGEY^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",5,0)="DATE/TIME OF DICTATION^DICTATION DATE/TIME^1301^TIUDDT^5/16/97@09:25^0^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",6,0)="LOCATION^PATIENT LOCATION^1205^TIULOC^MEDICAL-CONSULT 6200^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",7,0)="EXPECTED COSIGNER^EXPECTED COSIGNER^1208^^WELBY,MARCUS^1^0"
 . S ^TIU(8925.1,TIUDA,"HEAD",8,0)="CONSULT REQUEST NUMBER^CONSULT REQUEST #^1405^TIUCNNBR^1455^1^1"
 . S ^TIU(8925.1,TIUDA,"HEAD",8,1)="S X=""C.""_X"
 Q
ATTACH(TIUDA,TIULVL) ; Attach CONSULTS to appropriate parent
 N DIC,DLAYGO,DIE,DR,TIULNM,TIUSEQ,X,Y
 S TIULNM=$S(TIULVL="DC":"DOCUMENT CLASS",1:"CLASS")
 W !!,"FANTASTIC! Your NEW ",TIULNM," CONSULTS will now be added under"
 S DA(1)=$S(TIULVL="DC":3,1:38)
 W !,"the ",$P(^TIU(8925.1,DA(1),0),U)," Class...",!
 S DIC="^TIU(8925.1,"_DA(1)_",10,",DIC(0)="NXL"
 S DIC("P")=$P(^DD(8925.1,10,0),U,2),X="`"_TIUDA
 D ^DIC ; Create the sub-entry for CONSULTS
 I +Y'>0 D  Q
 . W !!,$C(7),"Unable to add CONSULTS under ",$P($G(^TIU(8925.1,DA(1),0)),U)
 . W !,"You'll have to attach it manually."
 S DA=+Y,DIK=DIC,TIUSEQ=$P(@(DIC_"0)"),U,4) K DIC
 S ^TIU(8925.1,DA(1),10,DA,0)=$G(^TIU(8925.1,DA(1),10,DA,0))_U_TIUSEQ_U_TIUSEQ_U_"Consults"
 D IX^DIK ; Cross-reference new subfile entry
 Q
CLPAC() ; Get pointer to CLINICAL COORDINATOR User Class
 N TIUY
 S TIUY=$O(^USR(8930,"B","CLINICAL COORDINATOR",0))
 Q TIUY
