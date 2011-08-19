EASECSC1 ;ALB/PHH,LBD,EG,ERC - LTC Co-Pay Test Screen Military Service ; 05/06/2006 4:17 PM
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,38,62,75,70**;Mar 15, 2001;Build 26
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTACT  LTC Co-Pay Test Action
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ; Output -- None
 ;
EN ;Entry point
 N DGLTCEX,DGLTC,IORVON,IORVOFF
 D ^DGRPV
 D EASECRP6
 S X="IORVON;IORVOFF" D ENDR^%ZISS K X
 I $G(DGLTCEX) W !?2,$G(IORVON)," * VETERAN MAY BE EXEMPT FROM COPAY IF LTC EPISODE IS DUE TO THIS CONDITION.",$G(IORVOFF)
 S X="^2"
 S:$$PAUSE(0) X="^"
 G EN1^EASECSCR
 Q
PAUSE(RESP) ; Prompt user for next page or quit
 N DIR,DIRUT,DUOUT,DTOUT,U,X,Y
 S DIR(0)="E"
 D ^DIR
 I 'Y S RESP=1
 Q RESP
 ;
EASECRP6 ; Display the screen
 ; Note: This section was copied from ^DGRP6 and modified specifically
 ;       to work with LTC.
 ;
 S (DGRPS,DGMTSCI)=1 D HD^EASECSCU F I=.32,.321,.322,.36,.52,.53 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 S (DGRPW,Z)=1 D WW S Z="    Service Branch",Z1=24 D WW1^DGRPV S Z="   Service #",Z1=19 D WW1^DGRPV S Z="   Entered",Z1=12 D WW1^DGRPV S Z="   Separated",Z1=12 D WW1^DGRPV W "   Discharge"
 W !?4,"--------------",?27,"---------",?46,"-------",?58,"---------",?70,"---------"
 S DGRPX=DGRP(.32),DGRPSV=4 D S I $P(DGRPX,"^",19)="Y" S DGRPSV=9 D S I $P(DGRPX,"^",20)="Y" S DGRPSV=14 D S
 S Z=2,DGRPX=DGRP(.52) D WW W "           POW: " S X=5,Z1=6 D YN W "From: " S X=7,Z1=13 D DAT W "To: " S X=8,Z1=12 D DAT W "War: ",$S($D(^DIC(22,+$P(DGRPX,"^",6),0)):$P(^(0),"^",2),1:"")
 S Z=3 D WW W "        Combat: " S X=11,Z1=6 D YN W "From: " S X=13,Z1=13 D DAT W "To: " S X=14,Z1=12 D DAT W "Loc: ",$S($D(^DIC(22,+$P(DGRPX,"^",12),0)):$P(^(0),"^",2),1:"")
 S Z=4,DGRPX=DGRP(.321) D WW W "       Vietnam: " S X=1,Z1=6 D YN W "From: " S X=4,Z1=13 D DAT W "To: " S X=5,X1=13 D DAT
 S Z=5 D WW W "      A/O Exp.: " S X=2,Z1=7,DGLTC=1 D YN W "Reg: " S X=7,Z1=11 D DAT W "Exam: " S X=9,Z1=11 D DAT W "A/O#: " S Z=$P(DGRPX,"^",10),Z1=8 D WW1^DGRPV S Z=$P(DGRPX,"^",13) W $S(Z="K":" DMZ",Z="V":"VIET",1:"")
 S Z=6 D WW W "      ION Rad.: " S X=3,Z1=7,DGLTC=1 D YN W "Reg: " S X=11,Z1=9 D DAT W "Method: "
 S X=$P(DGRPX,"^",12) W $S(X=2:"HIROSHIMA/NAGASAKI",X=3:"ATMOSPHERIC NUCLEAR TESTING",X=4:"H/N AND ATMOSPHERIC TESTING",X=5:"UNDERGROUND NUCLEAR TESTING",X=6:"EXPOSURE AT NUCLEAR FACILITY",X=7:"OTHER",1:"")
 S DGRPX=DGRP(.322)
 F DGX=1,4,7,10 S X=DGX,Z=DGX-1/3+7 D WW W:DGX<10 " " W $S(DGX=1:"      Lebanon",DGX=4:"      Grenada",DGX=7:"       Panama",1:"      Gulf War"),": " S Z1=6 D YN W "From: " S X=DGX+1,Z1=13 D DAT W "To: " S X=DGX+2,Z1=12 D DAT
 S Z=11 D WW W "       Somalia: " S (DGX,X)=16,Z1=6 D YN W "From: " S X=17,Z1=13 D DAT W "To: " S X=18,Z1=12 D DAT
 ; Contam name changed to SW Asia Conditions, DG*5.3*688
 S Z=12 D WW W "  SW Asia Cond: " S X=13,Z1=7,DGLTC=1 D YN W "Reg: " S X=14,Z1=11 D DAT W "Exam: " S X=15,Z1=10 D DAT
 S Z=13 D WW S X=$P(DGRP(.36),"^",12)
 W "      Mil Disab Retirement: ",$S(X=0:"NO",X=1:"YES",1:"")
 S Z=21 S X=$P(DGRP(.36),U,13)
 W "           Dischrg Due to Disab: ",$S(X=1:"YES",X=0:"NO",1:"")
 S Z=14 D WW W "      Dent Inj: " S DGRPX=DGRP(.36),X=8,Z1=28 D YN W "Teeth Extracted: " S X=9,Z1=9 D YN S DGRPD=0 I $P(DGRPX,"^",8)="Y",$P(DGRPX,"^",9)="Y" S DGRPD=1
 I DGRPD S I1="" F I=0:0 S I=$O(^DPT(DFN,.37,I)) Q:'I  S I1=1,DGRPX=^(I,0) D DEN
 S DGRPX=DGRP(.322)
 S Z=15 D WW W "    Yugoslavia: " S (DGX,X)=19,Z1=6 D YN W "From: " S X=20,Z1=13 D DAT W "To: " S X=21,Z1=12 D DAT
 S Z=16 D WW W "  Purple Heart: " S DGRPX=DGRP(.53),X=1 D YN D
 . I $P($G(DGRPX),U)="Y",($P($G(DGRPX),U,2)]"") W ?26,"PH Status: "_$S($P($G(DGRPX),U,2)="1":"Pending",$P($G(DGRPX),U,2)="2":"In Process",$P($G(DGRPX),U,2)="3":"Confirmed",1:"")
 I $P($G(DGRPX),U)="N" D
 . S DGX=$P(DGRPX,U,3)
 . S DGX=$S($G(DGX)=1:"UNACCEPTABLE DOCUMENTATION",$G(DGX)=2:"NO DOCUMENTATION REC'D",$G(DGX)=3:"ENTERED IN ERROR",$G(DGX)=4:"UNSUPPORTED PURPLE HEART",$G(DGX)=5:"VAMC",$G(DGX)=6:"UNDELIVERABLE MAIL",1:"")
 . I $G(DGX)]"" W ?26,"PH Remarks: "_$S($G(DGX)]"":$G(DGX),1:"")
 S Z=17 D WW W "    N/T Radium: " D     ;N/T Radium Treatment expos.
 . N DGNT S DGRPX=$$GETCUR^DGNTAPI(DFN,"DGNT") W $G(DGNT("INTRP")) I $G(DGNT("INTRP"))["YES" W "*" S DGLTCEX=1
Q K DGRPD,DGRPSV
 Q
YN S Z=$S($P(DGRPX,"^",X)="Y":"YES",$P(DGRPX,"^",X)="N":"NO",$P(DGRPX,"^",X)="U":"UNK",1:"") S:Z="YES"&($G(DGLTC)) Z=Z_"*",DGLTCEX=1 D WW1^DGRPV K DGLTC Q
DAT S Z=$P(DGRPX,"^",X) I Z']"" S Z=""
 E  S Z=$$FMTE^XLFDT(Z,"5DZ")
 D WW1^DGRPV Q
DEN W !?3," Trt Date: " S X=1,Z1=10 D DAT W "Cond.: ",$E($P(DGRPX,"^",2),1,45) Q
S N DGRPSB S DGRPSB=+$P(DGRPX,U,DGRPSV+1)  ;Service Branch
 W !?4,$S($D(^DIC(23,DGRPSB,0)):$E($P(^(0),"^",1),1,15),1:DGRPU) W:$$FV^DGRPMS(DGRPSB)=1 ?20,"("_$P(DGRP(.321),U,14)_")"
 W ?27,$S($P(DGRPX,"^",DGRPSV+4)]"":$P(DGRPX,"^",DGRPSV+4),1:DGRPU)
 F I=2,3 S X=$P(DGRPX,"^",DGRPSV+I),X=$S(X]"":$$FMTE^XLFDT(X,"5DZ"),1:"UNKNOWN") W ?$S(I=2:46,1:58),X
 W ?70,$S($D(^DIC(25,+$P(DGRPX,"^",DGRPSV),0)):$E($P(^(0),"^",1),1,9),1:"UNKNOWN") Q
MR W !?19,"Receiving Military retirement in lieu of VA Compensation." Q
WW ;Write number on screens for display and/or edit (Z=number)
 ; NOTE: This section was copied from WW^DGRPV and modified specifically
 ;       for LTC.  The code calling ^DGRPV has been redirected here.
 W:DGRPW !
 Q
