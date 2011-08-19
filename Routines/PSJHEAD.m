PSJHEAD ;BIR/KKA-PROFILE HEADER ; 4/1/08 4:29pm
 ;;5.0; INPATIENT MEDICATIONS ;**8,20,85,95,203**;16 DEC 97;Build 13
 ;
 ; Reference to ^PS(55 supported by DBIA #2191.
 ;
ENTRY(DFN,PSJOPC,PG,PSJNARC,PSJTEAM,PSJY2K)   ;
 ;DFN=patient internal entry number
 ;PSJOPC=a code showing what type of option is printing the header
 ;PG=page number
 ;PSJNARC=code telling whether or not to print narrative
 ;PSJTEAM=code telling whether or not to print team
 ;PSJY2K=code telling whether or not to print 4 digit year
STUFF ;
 N %,ALFLG,GONE,HDT,KKA,LEN,LENCHK,PSGALG,PSGADR,PSGDT,PSGVWA,PSJPAD,PSJPAGE,PSJPDD,PSJPDOB,PSJPDX,PSJPHT,PSJPHTD,PSJPPID,PSJPR,PSJPRB,PSJPSEX,PSJPTD,PSJPWD,PSJPWDN,PSJPWT,PSJWTD,RB,SI,TEAM,VA,VA200,VADM,VAIN,VAIP,WCNT,WRD,X
 ;
 ;PPAGE=the page of the individual we are now printing. This is needed to keep track of how we print the Allergy/ADR info
 ;PSJNEW is set at the top of all options which call this header, if this is the first time the option has called the routine, PSJNEW will exist
 ;
 I $D(PSJNEW) S PSGPTMP=0,PPAGE=1 K PSJNEW
 S PSGP=DFN S:PSGP=$G(PSGPTMP) PPAGE=PPAGE+1 I PSGP'=$G(PSGPTMP) S PSGPTMP=PSGP,PPAGE=1
 D NOW^%DTC S PSGDT=%,HDT=$$ENDTC^PSGMI(PSGDT)
 S VA200=1 D INP^VADPT
 I VAIN(4) S PSJPWD=+VAIN(4),PSJPWDN=$P(VAIN(4),"^",2),(PSJPRB,RB)=VAIN(5),PSJPAD=+VAIN(7),PSJPDX=VAIN(9),PSJPDD="",PSJPTD=$S($D(^PS(55,DFN,5.1)):$P(^(5.1),"^",4),1:"")
 I 'VAIN(4) S VAIP("D")="L" D IN5^VADPT S PSJPWD=+VAIP(5),PSJPWDN=$P(VAIP(5),"^",2),(PSJPRB,RB)=$P(VAIP(6),"^",2),PSJPAD=+VAIP(13,1),PSJPDX=VAIP(9) D
 .S PSGID=+VAIP(3),X=+VAIP(4)=12!(+VAIP(4)=38),PSJPTD="",PSJPDD=PSGID_"^"_$$ENDTC^PSGMI(PSGID) S:X PSJPDD=PSJPDD_"^1"
 D DEM^VADPT,HTWT^PSJAC(DFN)
 S PSGP(0)=VADM(1),PSJPDOB=+VADM(3),PSJPAGE=VADM(4),PSJPSEX=$S(VADM(5)]"":VADM(5),1:"?^____"),PSJPPID=VA("PID")
 F X="PSJPAD","PSJPDOB","PSJPTD" I $G(@X) S $P(@X,"^",2)=$S($D(PSJY2K):$$ENDTC2^PSGMI(+@X),1:$$ENDTC^PSGMI(+@X))
ENHEAD ; print new page, name, ssn, dob, and ward
 I $D(ENGET) S RB=$S($G(PSJPRB)]"":PSJPRB,1:"* NF *")
 S SLS="",$P(SLS," -",15)=""
 ;* I PSJOPC]"" W:$Y @IOF W ! W:PSJOPC="ALL" ?16,"I N P A T I E N T   M E D I C A T I O N S" W:PSJOPC="UD" ?19,"U N I T   D O S E   P R O F I L E" W:PSJOPC="IV" !,?19,"I V  P A T I E N T  P R O F I L E" W ?64,HDT,!,SLS,SLS,$E(SLS,1,24),!
 I PSJOPC]"" D
 . W:$Y @IOF
 . W ! W:PSJOPC="ALL" ?16,"I N P A T I E N T   M E D I C A T I O N S" W:PSJOPC="UD" ?19,"U N I T   D O S E   P R O F I L E" W:PSJOPC="IV" !,?19,"I V  P A T I E N T  P R O F I L E" W ?64,HDT
 . NEW X S X=$$SITE^PSGMMAR2(80)
 . W !?+X,$P(X,U,2),!,SLS,SLS,$E(SLS,1,24),!
 W ?1,$P(PSGP(0),"^"),?34,"  ",$S('PSJPDD:"",$G(PSJIVOF):"",1:"Last "),"Ward: ",$S(PSJPDD&($G(PSJIVOF)):"OUTPATIENT",PSJPWDN]"":PSJPWDN,1:"* NF *") W:$D(PSJPR) ?75-$L(PG),"Pg: ",PG-$D(PSGVWA)
 W !?4,"PID: ",PSJPPID W:'PSJPDD ?26 W:PSJPDD ?21,"Last " W "Room-Bed: ",$S(RB="":"* NF *",1:RB),?53,"Ht(cm): ",?61 W:PSJPHT["_" PSJPHT W:PSJPHT'["_" $J(PSJPHT,6,2) W ?68,PSJPHTD
 W !?4,"DOB: ",$S($D(PSJY2K):$E($P(PSJPDOB,"^",2),1,10),1:$E($P(PSJPDOB,"^",2),1,8))_"  ("_PSJPAGE_")"
 I (PSJTEAM=1)&(RB]"") S TEAM=$S($O(^PS(57.7,"AWRT",$G(PSJPWD),$G(RB),0)):$O(^(0)),1:"") S:TEAM]"" TEAM=$G(^PS(57.7,$G(PSJPWD),1,TEAM,0))
 I $D(TEAM) W ?30,"Team: ",$S(TEAM]"":TEAM,1:"* NF *")
 W ?53,"Wt(kg): ",?61 W:PSJPWT["_" PSJPWT W:PSJPWT'["_" $J(PSJPWT,6,2) W ?68,PSJPWTD
 W !?4,"Sex: ",$P(PSJPSEX,"^",2),?'PSJPDD*5+46,$S(PSJPDD:"Last ",1:""),"Admitted: ",$S($D(PSJY2K):$E($P(PSJPAD,"^",2),1,10),1:$E($P(PSJPAD,"^",2),1,8))
 W !?5,"Dx: ",$S(PSJPDX]"":PSJPDX,1:"* NF *") S X=$S(PSJPDD:PSJPDD,1:$G(PSJPTD)) I X W ?PSJPDD>0*6+43,$S(PSJPDD:"Discharged: ",1:"Last transferred: "),$S($D(PSJY2K):$E($P(X,"^",2),1,10),1:$E($P(X,"^",2),1,8))
 I PSJNARC=1 W !?1,"Pharmacy Narrative: " S WCNT=1,SI=$G(^PS(55,DFN,1)) W:SI=""&($E(IOST)="P") " ____________________" I SI]"" D
 .S LENCHK=0,LEN=$L(SI)
 .F  S WRD=$P(SI," ",WCNT) Q:$L(WRD)=0&(LENCHK'<LEN)  S WCNT=WCNT+1 W:$X+$L(WRD)>79 !,?21 W " ",WRD S LENCHK=LENCHK+$L(WRD)+1
 S PSGP=DFN,ALFLG=0 D ATS^PSJMUTL(68,68,2)
 W !?1,"Allergies: " D:PSGALG+PSGVALG+PSGADR+PSGVADR=0 NONE I PSGALG+PSGVALG+PSGADR+PSGVADR>0 D ALG,ADR I ALFLG D
 .W "See patient's first ",$S($E(IOST)="C":"screen",1:"page")," for Allergies/Adverse Reactions"
 I $D(^PS(55,DFN,5.1)),$P(^(5.1),"^",7) S X=$P(^(5.1),"^",10),X="* ALL "_$S($P(^(5.1),"^",7)=1:"UNIT DOSE ",1:"")_"ORDERS PLACED ON HOLD "_$E("(",X]"")_X_$E(")",X]"")_" *" W $C(7),!!?80-$L(X)\2,X
 Q
NONE ;
 ;W:$E(IOST)="P" "______________________________" W !?7,"ADR: " W:$E(IOST)="P" "____________________________________"
 W "No Allergy Assessment" W !?7,"ADR: " W:$E(IOST)="P" "____________________________________"
 Q
ALG ;
 I PPAGE>1&((PSGALG'<68)!(PSGADR'<63)) S ALFLG=1 Q
 I PSGVALG(1)["NKA",(PSGALG(1)["NKA") S PSGALG(1)=""
 I PSGALG=20,(PSGALG(1)["__________") D
 . I PSGVADR=20,(PSGVADR(1)["__________") S PSGALG(1)="" S:PSGVALG(1)["__________" PSGVALG(1)="No Allergy Assessment"
 S KKA=0 F  S KKA=$O(PSGVALG(KKA)) Q:'KKA  W:KKA>1 !?12 W PSGVALG(KKA)
 I PSGALG(1)]"",(PSGALG(1)'["__________") W !," NV Aller.: " D
 . S KKA=0 F  S KKA=$O(PSGALG(KKA)) Q:'KKA  W:KKA>1 !?12 W PSGALG(KKA)
 Q
ADR ;
 Q:ALFLG
 W !?7,"ADR: "
 I PSGVADR(1)["NKA",(PSGADR(1)["NKA") S PSGADR(1)=""
 I PSGADR=20,(PSGADR(1)["__________") S PSGADR(1)=""
 S KKA=0 F  S KKA=$O(PSGVADR(KKA)) Q:'KKA  W:KKA>1 !?12 W PSGVADR(KKA)
 I PSGADR(1)]"" W !?4,"NV ADR: " D
 . S KKA=0 F  S KKA=$O(PSGADR(KKA)) Q:'KKA  W:KKA>1 !?12 W PSGADR(KKA)
 Q
