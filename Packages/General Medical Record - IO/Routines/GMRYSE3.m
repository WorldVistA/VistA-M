GMRYSE3 ;HIRMFO/YH-ITEMIZED PATIENT I/O REPORT BY SHIFT PART 4 ;5/13/96
 ;;4.0;Intake/Output;;Apr 25, 1997
WIVINF ;
 S GDA=0 F  S GDA=$O(^TMP($J,"GMRY",GDATE,GSFT,GIO,GHR,GIVDT,GIVTYP,GSUB,GDA)) Q:GDA'>0!GMROUT  S GDATA=$G(^TMP($J,"GMRY",GDATE,GSFT,GIO,GHR,GIVDT,GIVTYP,GSUB,GDA)),GAMT=+$P(GDATA,"^") D
 .I GIVTYP="Z" D WCARE Q
 .I GAMT>3000 D START Q
 .I GDA=2 S (GTYP,GIN)=$P(GDATA,"^",2),GIN=$S(GIN="B":2,GIN="A"!(GIN="P")!(GIN="L"):1,GIN="H"!(GIN="I"):3,1:0) Q:GIN=0  D ADD^GMRYSE2,WIV Q
 .I GDA=3 D
 ..S GPORT=$G(^GMR(126,DFN,"IV",GSUB,3))
 ..D:($Y+10)>IOSL HEADER2^GMRYSE1 Q:GMROUT  D WHR Q:GMROUT  W ?14
 ..S GTXT(1)=$P(GDATA,"^",5)_" "_$P(GDATA,"^",4)_$S(GPORT'="":" ("_GPORT_")",1:"")_"  infusion rate adjusted: "_$S(+$P(GDATA,"^")>0:$P(GDATA,"^"),1:"UNKNOWN")_" mls/hr"_$S($P(GDATA,"^",6)'="":" - "_$P(GDATA,"^",6),1:"")
 ..I $L(GTXT(1))>0 D WLINE
 ..S GNURSE=+$P(GDATA,"^",2) D WNURS
 Q
START ;
 D:($Y+10)>IOSL HEADER2^GMRYSE1 Q:GMROUT  S GCATH=$P(GDATA,"^",6),GTYP=$P(GDATA,"^",4),GSITE=$P(GDATA,"^",2),GSOL=$P(GDATA,"^",3),GVOL=$P(GDATA,"^",5),GNURSE=+$P(GDATA,"^",7) W "  " D WHR
 S GPORT=$P($G(^GMR(126,DFN,"IV",GSUB,3)),"^") D WTYPE
 S GTXT(1)=GTXT(1)_$S(GTYP'="L":"  "_GVOL_" mls ",1:"")_$S($P(GDATA,"^",11)["FLUSH":"flushed",GCATH'="":"started",1:"added")_"  Site: "_GSITE S:GCATH'="" GTXT(1)=GTXT(1)_"  IV cath: "_GCATH
 S GTXT(1)=GTXT(1)_$S(GPORT'="":" ("_GPORT_")",1:"")_$S(+$P(GDATA,"^",12)>0:" Rate: "_+$P(GDATA,"^",12)_" ml/hr",1:"")
 I $L(GTXT(1))>0 D WLINE
 D WNURS Q:$P(GDATA,"^",9)=""  S GSAVE=GHR,GHR=$P(GDATA,"^",9),GNURSE=+$P(GDATA,"^",10),GREASON=$S($P(GDATA,"^",11)'="":$P(GDATA,"^",11),1:"")
 I GTYP="L" S GREASON=$S($P(GDATA,"^",11)="INFUSED"!($P(GDATA,"^",11)="FLUSHED"):"",1:GREASON)
 I GSOL'="*" D
 . D:($Y+10)>IOSL HEADER2^GMRYSE1 W ?20,"Discontinued on "_$E(GHR,4,5)_"/"_$E(GHR,6,7)_"/"_$E(GHR,2,3)_" @ " D WDC W:GREASON'=""&(IOM'>80) !,?20,"Reason: "_GREASON W:GREASON'=""&(IOM>80) "   Reason: "_GREASON D WNURS S GHR=GSAVE K GSAVE
 Q
WIV ;PRINT IV INTAKE
 S GNURSE=+$P(GDATA,"^",4),GSITE=$P(GDATA,"^",3),GSOL=$P(GDATA,"^",5)
 I GTYP'="L" D
 .D:($Y+10)>IOSL HEADER2^GMRYSE1 Q:GMROUT  D WHR Q:GMROUT  D WTYPE S GTXT(1)=GTXT(1)_"      Intake Vol: "_$S($P(GDATA,"^",6)["*":"unknown",1:GAMT_" mls")_"   Remaining amount: "_$P(GDATA,"^",6)_" mls "
 .I $L(GTXT(1))>0 D WLINE
 .D WNURS
 Q
WTYPE ;PRINT IV TYPE
 S GTXT(1)=GSOL_" "_$S(GTYP="A":"admix",GTYP="B":"blood",GTYP="P":"piggy",GTYP="H":"hyper",GTYP="I":"intra",1:"")
 Q
WHR ;
 I GHOLD=$E(GHR,1,12) Q
 S GHR(1)=$E($P(GHR,".",2),1,4),GLEN=$L(GHR(1)),GTIME=$S(GLEN=1:GHR(1)_"000",GLEN=2:GHR(1)_"00",GLEN=3:GHR(1)_"0",1:GHR(1))
 W ?4,$E(GTIME,1,2),":",$E(GTIME,3,4)_"  "
 S GHOLD=$E(GHR,1,12) Q
WNURS G:$S(GNURSE=0:1,'$D(^VA(200,GNURSE,0)):1,$P(^VA(200,GNURSE,0),"^")="":1,1:0) Q S GCOL=$S(IOM>80:120,1:70) W ?GCOL,$E($P($P(^VA(200,GNURSE,0),"^"),",",2)),$E($P(^(0),"^"))
 S GPOS="" I GNURSE>0,$D(^NURSF(211.8,"C",GNURSE)) S GLOC=$O(^NURSF(211.8,"C",GNURSE,0)) S:$D(^NURSF(211.8,GLOC,0)) GPOS=$P(^(0),"^",2)
 W "/"_$S(GPOS="R":"RN",GPOS="L":"LPN",GPOS="N":"NA",GPOS="C":"CL",1:"OTH")
Q W ! Q
WCARE ;
 Q:$P(GDATA,"^",2)=""&($P(GDATA,"^",3)="")&($P(GDATA,"^",4)="")  D WHR S GTXT(1)=$P(GDATA,"^",8)_": " S GSAVE=$L(GTXT(1)),GMRY=$P(GDATA,"^",2),GTXT(1)=GTXT(1)_$S(GMRY'="":GMRY,1:"")
 S GMRY=$S($P(GDATA,"^",4)="Y":$P(GDATA,"^",4),1:""),GTXT(1)=GTXT(1)_$S(GMRY'=""&($L(GTXT(1))>GSAVE):", ",1:"")_$S(GMRY="Y":"dressing changed",1:"")
 S GMRY=$P(GDATA,"^",6),GTXT(1)=GTXT(1)_$S($L(GTXT(1))>GSAVE&(GMRY'=""):", ",1:"")_$S(GMRY="Y":"site discontinued",1:"")
 I $L(GTXT(1))>0 D WLINE
 I $P(GDATA,"^",3)["Y" D
 . S GSITE=$P(GDATA,"^",8),GIEN=+$P(GDATA,"^",7),GPORT=$S($D(^GMR(126,DFN,"IV",GIEN,3)):^(3),1:""),GSITE(GSITE)="" D FINDCA^GMRYCATH(.GSITE)
 . S GTXT(1)="  "_GSITE(GSITE)_$S(GPORT'="":" - "_GPORT,1:"")_" tubing changed" D WLINE
Q2 K GMR100,GMR101,GMR102,GTXT,GMRLEN
 S GNURSE=+$P(GDATA,"^",5) D WNURS
 Q
WDC ;
 S GHR(1)=$E($P(GHR,".",2),1,4),GLEN=$L(GHR(1)),GTIME=$S(GLEN=1:GHR(1)_"000",GLEN=2:GHR(1)_"00",GLEN=3:GHR(1)_"0",1:GHR(1)) W $E(GTIME,1,2)_":"_$E(GTIME,3,4) Q
WLINE ;PRINT DESCRIPTION
 N X S DIWR=$S(IOM>80:100,1:50),DIWF="",DIWL=0,X=GTXT(1) K ^UTILITY($J) D ^DIWP
 S GMRI=0 F  S GMRI=$O(^UTILITY($J,"W",0,GMRI)) Q:GMRI'>0   D:($Y+10)>IOSL HEADER2^GMRYSE1 Q:GMROUT  W !,?14,^UTILITY($J,"W",0,GMRI,0)
 K ^UTILITY($J),GMRI Q
