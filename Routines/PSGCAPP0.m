PSGCAPP0 ;BIR/CML3-PRINT DATA FOR ACTION PROFILE CONT. ; 4/1/08 3:05pm
 ;;5.0; INPATIENT MEDICATIONS ;**8,20,85,169,203**;16 DEC 97;Build 13
 ;
H1 ; first header for patient
 I $E(IOST,1)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT)!$D(DUOUT) PSJDLW=1 I $D(DTOUT)!$D(DUOUT) Q
 S (N,DF)=0,PSEX=$P(PI,"^"),PDOB=$P(PI,"^",2),PID=$P(PI,"^",3),RB=$P(PI,"^",5),AD=$P(PI,"^",6),TD=$P(PI,"^",7),WT=$P(PI,"^",8),WTD=$P(PI,"^",9),HT=$P(PI,"^",10),HTD=$P(PI,"^",11),PPN=$P(PI,"^",12),PI=$P(PI,"^",4),PSGP=$P(PN,"^",2)
 S PAGE=$P(PDOB,";",2),PDOB=$P(PDOB,";"),PG=1
 W:$Y @IOF W !?26,"UNIT DOSE ACTION PROFILE #2",?62,PSGPDT,!?+PSGVAMC,$P(PSGVAMC,U,2),!?23,"(Continuation of VA FORM 10-1158)",?72,"Page: 1",!,LINE
 W !,"   A new order must be written for any new medication or to make any changes",!," in dosage or directions on an existing order.",!,LINE
 W !?32-(PSGAPS="P"*13),$S(PSGAPS="T":"Team: ",1:"Treating Provider: "),PS1,!?1,PPN,?32,"Ward: "_WD,!?4,"PID: "_PID W:'PSJPDD ?28 W:PSJPDD ?23,"Last " W "Room-Bed: ",RB,?53,"Ht(cm): ",HT," ",HTD
 W !?4,"DOB: "_PDOB_"  ("_PAGE_")",?53,"Wt(kg): "_WT," ",WTD
 W !?4,"Sex: "_PSEX,?51,"Admitted: "_AD
 ;
 W !?5,"Dx: "_PI W:TD ?43,"Last Transferred: "_TD
 ;
 S PSGP=$P(PN,U,2) S:PSGP=$G(PSGPTMP) PPAGE=PPAGE+1 I PSGP'=$G(PSGPTMP) S PSGPTMP=PSGP,PPAGE=1
 S ALFLG=0 D ATS^PSJMUTL(68,68,2)
 ; PSJ*5*169 Make the allergy/ADR algorithm consistent with one used in PSJHEAD for AP-1 report.
 W !?1,"Allergies: " D:PSGALG+PSGVALG+PSGADR+PSGVADR=0 NONE I PSGALG+PSGVALG+PSGADR+PSGVADR>0 D ALG^PSJHEAD,ADR^PSJHEAD I ALFLG D
 .W "See patient's first ",$S($E(IOST)="C":"screen",1:"page")," for Allergies/Adverse Reactions"
 W !,LINE,!,"No. Action",?16,"Drug",?46,"ST Start Stop  Status/Info",!,ALN
 Q
NONE ;    
 ;W:$E(IOST)="P" "______________________________" W !?7,"ADR: " W:$E(IOST)="P" "____________________________________"
 W "No Allergy Assessment" W !?7,"ADR: " W:$E(IOST)="P" "____________________________________"
 Q
ALG ; NOT USED ANYMORE, ALG^PSJHEAD    
 I PPAGE>1&((PSGALG'<68)!(PSGADR'<63)) S ALFLG=1 Q
 S KKA=0 F  S KKA=$O(PSGALG(KKA)) Q:'KKA  W:KKA>1 !?12 W PSGALG(KKA)
 Q
ADR ; NOT USED ANYMORE, ADR^PSJHEAD 
 Q:ALFLG
 W !?7,"ADR: "
 S KKA=0 F  S KKA=$O(PSGADR(KKA)) Q:'KKA  W:KKA>1 !?12 W PSGADR(KKA)
 Q
 ;
ENRCT ;
 N DFN,GMRA,GMRAL,RCT,X S DFN=PSGP,GMRA="0^0^111" D ^GMRADPT
 S X=0 F  S X=$O(GMRAL(X)) Q:'X  I $P(GMRAL(X),U,2)]"" S RCT($P(GMRAL(X),U,2))=""
 ;W:'$D(RCT) "____________________" S RCT="" F X=1:1 S RCT=$O(RCT(RCT)) Q:RCT=""  W:X>1 "," W:$X+$L(RCT)>77 ! W " ",RCT
 W:'$D(RCT) "No Allergy Assessment" S RCT="" F X=1:1 S RCT=$O(RCT(RCT)) Q:RCT=""  W:X>1 "," W:$X+$L(RCT)>77 ! W " ",RCT
 W !,LINE,!," No.",?11,"Drug",?46,"ST Start Stop  Status/Info",!,ALN
 Q
