PSGOEE0 ;BIR/CML3-ORDER EDIT UTILITIES ; 10/7/08 11:08am
 ;;5.0;INPATIENT MEDICATIONS;**58,95,179,216,315**;16 DEC 97;Build 73
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^DICN is supported by DBIA 10009.
 ; Reference to ^DIR is supported by DBIA 10026.
 ;
ENSFE(PSGP,PSGORD) ; Determine editable fields, and fields that cause new order.
 D @$S(PSGORD["P":"ENSFE3^PSGOEE0",1:"ENSFE5^PSGOEE0")
 Q
ENSFE3 ; set-up fields to edit for 53.1
 I PSGSTAT="PENDING" S PSGEFN="1:13" F X=1:1:13 S PSGEFN(+X)=$P($T(@(3_X)),";",7),PSGOEEF(+$P($T(@(3_X)),";",3))="",PSGOEEF=PSGOEEF+1
 E  S PSGEFN="1:13" F X=1,2,3,4,5,6,7,8,9,10,11,12 S Y=$T(@(3_X)),@("PSGEFN("_+X_")="_$S($D(PSGOETOF):0,1:$P(Y,";",7))),PSGOEEF(+$P(Y,";",3))="",PSGOEEF=PSGOEEF+1
 E  S:$P(PSJSYSU,";",3)>1 PSGEFN(9)=0,PSGOEEF(+$P($T(39),";",3))="",PSGOEEF=PSGOEEF+1
 E  I PSGEB'=PSGOPR F X=10,13 S Y=$T(@(3_X)),@("PSGEFN("_X_")="_$S($D(PSGOETOF):0,1:$P(Y,";",7))),PSGOEEF(+$P(Y,";",3))="",PSGOEEF=PSGOEEF+1
 ;*216 highlight if DOSECHK fails
 N PSJDOSE D DOSECHK^PSJDOSE I +$G(PSJDSFLG),'$G(PSGOEEF(109)) S PSGOEEF(109)=1
 K PSGOEEND S PSGOEEG=3,PSGPDRG=PSGOPD,PSGPDRGN=PSGOPDN Q
 ;
ENSFE5 ; set-up fields to edit for 55
 S PSGEFN="1:13"
 F X=1:1:13 S Y=$T(@(5_X)),@("PSGEFN("_+X_")="_$S($D(PSGOETO):0,1:$P(Y,";",7))),PSGOEEF(+$P(Y,";",3))="",PSGOEEF=PSGOEEF+1
 I $P(PSJSYSU,";",3)>1 S PSGEFN(9)=0,PSGOEEF(+$P($T(59),";",3))="",PSGOEEF=PSGOEEF+1
 S PSGPDRG=PSGPD,PSGPDRGN=PSGPDN,PSGOEEND=1,PSGOEEG=5
 ;*216 highlight if DOSECHK fails
 N PSJDOSE D DOSECHK^PSJDOSE I +$G(PSJDSFLG),'$G(PSGOEEF(109)) S PSGOEEF(109)=1
 Q
 ;
ENOK ;
 I $P($G(PSJSYSP0),U,2),'$O(^PS(53.45,+PSJSYSP,2,0)) D
 .W !!,"No dispense drugs found for this order." D ENDRG^PSGOEF1(PSGPD,0) I '$O(^PS(53.45,+PSJSYSP,2,0)) S PSGOEENO=0,DR=""
 W ! I DR="",'PSGOEENO D ABORT^PSGOEE S %=1 Q
 W:PSGOEENO !,"(Accepting these changes will cause a new order to be created.)"
 F  W !!,"ACCEPT THESE CHANGES" S %=1 D YN^DICN Q:%  D  ;
 .W !!?2,"Answer 'YES' (or press RETURN) if you have completed editing this order." W:PSGOEENO !,"Accepting this changes will cause a new order to be created, and this order",!,"will be discontinued."
 .W:$D(PSGOEF) !,"Accepting these changes will convert this order to a non-verifed, Unit Dose",!,"order."
 .W !!,"Answer 'NO' to re-edit this order.  Enter an '^' to abort this edit."
 S PSJNOO=$$ENNOO^PSJUTL5("E")
 K F,F0,F1,F3,PSGDL,PSGDLS,PSGF2,PSGFOK,ND2,PSGOROE1,PSGRO,SDT
 S:PSJNOO<0 (PSGOROE1,PSGOEENO)=0
 Q
 ;
ENNOU ; create new order or update old order
 I $G(MSG) K DIR S DIR(0)="E" W !! D ^DIR
 K DR S DR="",(PSGOEENO,Q)=0
 F  S Q=$O(PSGEFN(Q)) Q:'Q  S Y=$T(@(PSGOEEG_Q)) I $P(Y,";",4)]"",@$P(Y,";",4)'=@$P(Y,";",5) S:PSGEFN(Q) PSGOEENO=1 Q:PSGOEENO  S DR=DR_$P(Y,";",6)_$S(@$P(Y,";",5)]"":"////^S X="_$P(Y,";",5),1:"////@")_";W ""."";"
 I PSGSI="",PSGOSI]"" S DR=DR_"122////@;W ""."";"
 I '$P(PSGSI,"^",2),$P(PSGOSI,"^",2)=1 S DR=DR_"122////@;W ""."";"
 ; PSJ*5*95 quick fix to prevent long string error; true fix in PSJ*5*91 (upd^psgoee)
 I PSGSI]"" S DR=DR_122_"////^S X="_+$P(PSGSI,"^",2)_";" I '$G(PSJLMFIN),'$G(PSGOEENO),$L($G(PSGOSI),"^")>20 S PSGSI=$P(PSGSI,"^")
 I PSGSM,PSGOHSM'=PSGHSM S DR=DR_"6////"_PSGHSM_";W ""."";"
 I +$G(PSGRF)]"" D 
 . S DR=DR_"137////"_$G(PSGDUR)_";138////"_$G(PSGRMVT)_";139////"_$G(PSGRMV)_";140////"_$G(PSGRF) ;*315
 . I $G(PSGAT) N FLD S FLD=$S(PSGORD["P":39,1:41),DR=DR_";"_FLD_"////"_$G(PSGAT) ;If DOA was edited then update the admin time.
 .Q
 ;PSJ*5.0*179
 N P I 'PSGOEENO F P="1^3^10" I $D(PSGEFN($P(P,U,3))) S (Q,QQ)=0 F  S Q=$O(@("^PS(53.45,"_PSJSYSP_","_+P_","_Q_")")) Q:'Q  S QQ=Q,X=$G(^(Q,0)),Y=$G(@(PSGOEEWF_$P(P,U,2)_","_Q_",0)")) I X'=Y S:+P=1 DR=DR_"*" Q
 I 'PSGOEENO F P="1^3^10" I $D(PSGEFN($P(P,U,3))) S (Q,QQ)=0 F  S Q=$O(@(PSGOEEWF_$P(P,U,2)_","_Q_")")) Q:'Q  S QQ=Q,X=$G(^(Q,0)),Y=$G(^PS(53.45,PSJSYSP,+P,Q,0)) I X'=Y S:+P=1 DR=DR_"*" Q
 Q:$S(DR]"":1,1:PSGOEENO)  S (Q,QQ)=0 F  S Q=$O(^PS(53.45,PSJSYSP,2,Q)) Q:'Q  S QQ=Q,X=$G(^(Q,0)),Y=$G(@(PSGOEEWF_"1,"_Q_",0)")) I X'=Y S DR=DR_"*" Q
 Q:$S(DR]"":1,1:PSGOEENO)  S (Q,QQ)=0 F  S Q=$O(@(PSGOEEWF_"1,"_Q_")")) Q:'Q  S QQ=Q,X=$G(^(Q,0)),Y=$G(^PS(53.45,PSJSYSP,2,Q,0)) I X'=Y S DR=DR_"*" Q
 Q
 ;
ENF ; finish order from edit
 F  S %=1 W !!,"Finish this order now" D YN^DICN Q:%  D  ;
 .W !!,"Answer 'YES' to finish this order now.  Finishing the order converts it to a",!,"non-verified Unit Dose order.  Enter 'NO' (or an '^') if you do not want to",!,"finish this order now."
 I %=1 S PSGOEFF=0 D UPD^PSGOEF1 K PSGOEFF,PSGND,PSGSD
 Q
 ;
FIELDS ;
31 ;;108^PSGOE8;PSGOPD;PSGPD;108;1
32 ;;109^PSGOE8;PSGODO;PSGDO;109;1
33 ;;10^PSGOE81;PSGOSD;PSGSD;10;0
34 ;;3^PSGOE8;PSGOMR;PSGMR;3;1
35 ;;25^PSGOE81;PSGOFD;PSGFD;25;0
36 ;;7^PSGOE8;PSGOST;PSGST;7;0
37 ;;5^PSGOE82;PSGOSM;PSGSM;5;0
38 ;;26^PSGOE8;PSGOSCH;PSGSCH;26;1
39 ;;39^PSGOE81;PSGOAT;PSGAT;39;0
310 ;;1^PSGOE82;PSGOPR;PSGPR;1;1
311 ;;8^PSGOE81;PSGOSI;PSGSI;8;0
312 ;;2^PSGOE82;;;2;0
313 ;;66^PSGOE82;;;66;0
314 ;;40^PSGOE82;;;40;0
51 ;;108^PSGOE9;PSGOPD;PSGPD;108;1
52 ;;109^PSGOE9;PSGODO;PSGDO;109;1
53 ;;10^PSGOE91;PSGOSD;PSGSD;10;1
54 ;;3^PSGOE9;PSGOMR;PSGMR;3;1
55 ;;34^PSGOE91;PSGOFD;PSGFD;34;1
56 ;;7^PSGOE9;PSGOST;PSGST;7;0
57 ;;5^PSGOE82;PSGOSM;PSGSM;5;0
58 ;;26^PSGOE9;PSGOSCH;PSGSCH;26;1
59 ;;41^PSGOE91;PSGOAT;PSGAT;41;0
510 ;;1^PSGOE92;PSGOPR;PSGPR;1;1
511 ;;8^PSGOE92;PSGOSI;PSGSI;8;0
512 ;;2^PSGOE92;;;2;0
513 ;;15^PSGOE92;;;15;0
514 ;;72^PSGOE92;;;72;1
