YSCUP002 ;DALISC/LJA -  Pt Move Utils: ADD, DELETE ;8/31/94 11:45
 ;;5.01;MENTAL HEALTH;**2,11,20,29**;Dec 30, 1994
 ;;
 ;
DELETE(MHIEN) ;  Delete ^YSG("INP" entry...
 QUIT:'$D(^YSG("INP",+MHIEN))  ;->
 ;
 S YSACTS=1
 ;
 N MH0,MH7,TIEN,WIEN
 ;
 ;  Set nodes, and record ^XTMP data...
 S MH0=$G(^YSG("INP",+MHIEN,0))
 S ^XTMP(YSXTMP,"PRE0-DEL",+MHIEN)=MH0
 S MH7=$G(^YSG("INP",+MHIEN,7))
 S ^XTMP(YSXTMP,"PRE7-DEL",+MHIEN)=MH7
 ;
 ;  Clean up XRefs...
 ;
 ;  .01  File Entry Date
 S X=$E($P(MH0,U),1,30) K:X]"" ^YSG("INP","B",X,+MHIEN)
 ;
 ;  1    Patient
 I YSNMH=1 D  ;About to delete the ONLY MH Inpt entry...
 .  K ^YSG("INP","C",+$P(MH0,U,2),+MHIEN)
 .  S YSNMH=0
 ;
 ;  AWC, CP xref
 S WIEN=+MH7,TIEN=+$P(MH7,U,4)
 K ^YSG("INP","AWC",+WIEN,+TIEN,+YSDFN)
 K ^YSG("INP","CP",+YSDFN)
 ;
 ;  Update AOUT xref
 I $P(MH7,U,2)]"" K ^YSG("INP","AOUT",9999999-$P(MH7,U,2),+MHIEN)
 ;
 ;  Delete AST xref...
 S YSFEDT=+$P(MH0,U),YSFEDT=$S(YSFEDT?7N.E:+YSFEDT\1,1:DT)
 S X1=+YSFEDT,X2=1 D C^%DTC S YSFEDT=X_".24"
 S X1=+(YSFEDT\1),X2=-6 D C^%DTC S YSBEDT=X\1
 I YSBEDT?7N.E D
 .  S YSLP="^YSG(""INP"",""AST"")"
 .  F  S YSLP=$Q(@YSLP) QUIT:YSLP']""!(YSLP'["AST")!(+$P(YSLP,",",3)<YSBEDT)  D
 .  .  QUIT:+$P(YSLP,",",6)'=MHIEN  ;->
 .  .  K @YSLP
 .  .  I '$D(ZTQUEUED),'$G(DGQUIET) W "."
 ;
 ;  Now, delete entry
 S DA=+MHIEN,DIK="^YSG(""INP"","
 D ^DIK
 ;
 QUIT
 ;
ADD(MOVNO) ;  Add ^YSG("INP" entry from MOVE data...
 S YSIEN=0
 S MOVE=$G(^TMP("YSPM",$J,+$G(MOVNO)))
 QUIT:$G(MOVE)']""  ;->
 ;
 S YSACTS=1
 ;
 N DA,DIC,DIE,DR
 S YSX=1 F I=2,3,5,6 I $P(MOVE,U,I)']"" S YSX=0
 I 'YSX D  QUIT  ;->
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W !!,"Movement data not complete... No Admission made..."
 ;
 I '$O(^TMP("YSPM",$J,"M",0)) D  QUIT  ;->
 .  I '$D(ZTQUEUED),'$G(DGQUIET) W !!,"No action taken..."
 ;  OK data.  Make YSG("INP" entry...
 ;  Use ^DGPM's Date/Time for .01 value.
 S X=+$O(^TMP("YSPM",$J,"M",0)),X=$P(^TMP("YSPM",$J,"M",+X),U,3) ;Use Admission DT
 I X'?7N.E S X=+$P(MOVE,U,6) ;If not available, use move's DT
 K DD
 S DIC="^YSG(""INP"",",DIC(0)="L",DLAYGO=618.4
 D FILE^DICN
 QUIT:+Y<0  ;->
 S YSIEN=+Y
 ;
 ;  Now, fill in fields...
 S DA=+YSIEN,DIE="^YSG(""INP"","
 S DR="1////"_+YSDFN ;                                 Patient
 I $P(MOVE,U,2)>0 S DR=DR_";20////"_$P(MOVE,U,2) ;     Ward
 I $P(MOVE,U,3)>0 D  ;                                 Team
 .  S DR=DR_";3////"_$P(MOVE,U,3)
 .  S DR=DR_";23////"_$P(MOVE,U,3)
 ;
 ;  Last Admission YSMP( entry... (See STORE^YSCUP003)
 S YSLADM=$S($P($G(YSLADM),U,5)>0:+$P(YSLADM,U,5),$P(MOVE,U,5)>0:+$P(MOVE,U,5),1:"")
 I YSLADM S DR=DR_";22///"_+YSLADM_"~" ; Admit pointer
 I $P(MOVE,U,6)?7N.E S DR=DR_";2////"_$P(MOVE,U,6) ;   Unit Entry Date
 D ^DIE
 ;
 ;  Now, update ^XTMP...
 S YSX=$G(^YSG("INP",+YSIEN,0))
 S:YSX]"" ^XTMP(YSXTMP,"POST0-ADD",+YSIEN)=YSX
 S YSX=$G(^YSG("INP",+YSIEN,7))
 S:YSX]"" ^XTMP(YSXTMP,"POST7-ADD",+YSIEN)=YSX
 QUIT
 ;
EOR ;YSCUP002 -  Pt Move Utils: ADD, DELETE ;8/31/94 11:45
