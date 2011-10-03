PXRRMDR1 ;HERN/BDB - PCE Missing Data Report ;11 Feb 04  10:10 AM
 ;;1.0;PCE;**174,168**;AUG 12, 1996;Build 14
 ;
DATASRC ; get Data Sources to print
 N ID,REC
 K PXDS
 K DIR,DIC
 S DIR(0)="Y",DIR("A")="Would you like to include ALL Data Sources"
 S DIR("B")="YES" D ^DIR
 I $D(DIRUT) S POP=1 Q
 I Y D
 . S ID="" F  S ID=$O(^PX(839.7,"B",ID)) Q:ID=""  D
 . . S REC="" F  S REC=$O(^PX(839.7,"B",ID,REC)) Q:REC=""  D
 . . . S PXDS(REC)=ID
 . S PXDS("Unknown")=0
 E  D
 . S DIC=839.7,DIC(0)="QEAMZ",DIC("A")="Enter Data Source:  "
 . F  D ^DIC Q:$D(DTOUT)!($D(DUOUT))!(Y=-1)  S:+Y PXDS(+Y)=""
 I $D(DTOUT)!($D(DUOUT)) S POP=1
 Q
 ;
PRINT ; Print Report
 N A,I,REC,TOT,TOTE,Y,SHDR
 N PAT,SSN,SSND,TYP,VIN,DEFD,ENCD
 K TOT,TOTE
 S DEFD="TOTAL DEFECTS FOR ",ENCD="TOTAL ENCOUNTERS FOR "
 S (TOT(1),TOTE(1))=0
 S LOC="" F  S LOC=$O(^TMP("PXCRPW",$J,LOC)),HDR=0 Q:LOC=""!(POP)  D
 . S (TOT(2),TOTE(2))=0
 . S PROV="" F  S PROV=$O(^TMP("PXCRPW",$J,LOC,PROV)) Q:PROV=""!(POP)  D
 . . S (TOT(3),TOTE(3))=0
 . . S SORT="" F  S SORT=$O(^TMP("PXCRPW",$J,LOC,PROV,SORT)) Q:SORT=""!(POP)  D
 . . . S (TOT(4),TOTE(4))=0
 . . . S VDT="" F  S VDT=$O(^TMP("PXCRPW",$J,LOC,PROV,SORT,VDT)) Q:VDT=""!(POP)  D
 . . . . S (TOT(5),TOTE(5))=0
 . . . . S VIN="" F  S VIN=$O(^TMP("PXCRPW",$J,LOC,PROV,SORT,VDT,VIN)),HDR1=0 Q:VIN=""!(POP)  D
 . . . . . S TOT(6)=0
 . . . . . S TOTE(5)=TOTE(5)+1
 . . . . . S PR="" F  S PR=$O(^TMP("PXCRPW",$J,LOC,PROV,SORT,VDT,VIN,PR)) Q:PR=""  D
 . . . . . . S SHDR=0
 . . . . . . S SDX="" F  S SDX=$O(^TMP("PXCRPW",$J,LOC,PROV,SORT,VDT,VIN,PR,SDX)) Q:SDX=""!(POP)  D
 . . . . . . . S REC=^TMP("PXCRPW",$J,LOC,PROV,SORT,VDT,VIN,PR,SDX)
 . . . . . . . S PAT=$$GET1^DIQ(9000010,REC_",",.05)
 . . . . . . . S SSN=$$GET1^DIQ(2,$$GET1^DIQ(9000010,REC_",",.05,"I"),.09)
 . . . . . . . S SSND=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 . . . . . . . S EDT=$$GET1^DIQ(9000010,REC_",",.01)
 . . . . . . . S TYP=$$GET1^DIQ(9000010,REC_",",15001)
 . . . . . . . S USR=$$GET1^DIQ(9000010,REC_",",.23)
 . . . . . . . D:HDR=0 HEADER Q:POP
 . . . . . . . I RPTYP="D" D
 . . . . . . . . I HDR1=0 D
 . . . . . . . . . W ! S $P(HLINE,"-",132)="" W HLINE
 . . . . . . . . . W !,$E(PAT,1,25),?26,SSND,?39,EDT,?59,$E(TYP,1,15),?75,$E(USR,1,15) S HDR1=1
 . . . . . . . . W ?94,$E(SDX,1,37),!
 . . . . . . . S TOT(6)=TOT(6)+1
 . . . . . . . I $Y>(IOSL-4) S HDR=0
 . . . . . . Q:POP
 . . . . . Q:POP
 . . . . . I $Y>(IOSL-4) D HEADER Q:POP
 . . . . . S SHDR=1
 . . . . . W:RPTYP="D" !?94,DEFD_TYP_":  ",TOT(6),!
 . . . . . S TOT(5)=TOT(5)+TOT(6)
 . . . . Q:POP
 . . . . W !?6,DEFD_VDT_":  ",TOT(5)
 . . . . W !?6,ENCD_VDT_":  ",TOTE(5)
 . . . . S TOT(4)=TOT(4)+TOT(5)
 . . . . S TOTE(4)=TOTE(4)+TOTE(5)
 . . . Q:POP
 . . . W !?4,DEFD_"SORT VALUE - "_SORT_": ",TOT(4)
 . . . W !?4,ENCD_"SORT VALUE - "_SORT_": ",TOTE(4)
 . . . S TOT(3)=TOT(3)+TOT(4)
 . . . S TOTE(3)=TOTE(3)+TOTE(4)
 . . Q:POP
 . . W !?2,DEFD_PROV_": ",TOT(3)
 . . W !?2,ENCD_PROV_": ",TOTE(3)
 . . S TOT(2)=TOT(2)+TOT(3)
 . . S TOTE(2)=TOTE(2)+TOTE(3)
 . Q:POP
 . W !,DEFD_LOC_":  ",TOT(2)
 . W !,ENCD_LOC_": ",TOTE(2)
 . S TOT(1)=TOT(1)+TOT(2)
 . S TOTE(1)=TOTE(1)+TOTE(2)
 Q:POP
 I TOT(1)+TOTE(1)=0 W !!,"No Data to print",! Q
 W !!,"GRAND TOTAL NUMBER OF DEFECTS:  ",TOT(1)
 W !,"GRAND TOTAL NUMBER OF ENCOUNTERS = ",TOTE(1)
 Q
 ;
HEADER ;print header
 N %,X,Y,MSG,HLINE,DLINE
 I (PXPAGE>0)&(($E(IOST)="C")&(IO=IO(0))) D
 . S DIR(0)="E"
 . W !
 . D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) D  Q
 . S POP=1
 I PXPAGE>0 W:$D(IOF) @IOF
 S PXPAGE=PXPAGE+1
 W !
 S X=$$CTR132("PCE MISSING DATA REPORT") W !
 D NOW^%DTC S Y=% X ^DD("DD") S X=$$CTR(Y) W !
 S X=$$CTR132("By Clinic, Provider, and Date") W !
 S Y=PX("BDT") X ^DD("DD") S STDT=$P(Y,"@",1)
 S Y=PX("EDT") X ^DD("DD") S ENDT=$P(Y,"@",1)
 S MSG=STDT_" through "_ENDT
 S X=$$CTR(MSG) W !
 S X=$$CTR132("Page "_PXPAGE) W !
 W !!,"Patient",?26,"SSN",?39,"Date/Time",?59,"Enc. ID",?75,"Created by User",?94,"Defect",!
 S $P(HLINE,"=",132)="" W HLINE,!
 Q:SHDR
 W !,LOC
 W !?2,PROV
 N SORTD S SORTD=SORT
 S:SORTD=" " SORTD="Unknown"
 W !?4,"SORT VALUE:  ",$P(SORTHDR,U,PXSRT),"= ",SORTD
 S:VDT="" VDT="Unknown"
 W !?6,$P(VDT,"@",1),":"
 S HDR=1
 Q
 ;
CTR(X) ;
 W ?(IOM-$L(X))\2,X
 Q 1
 ;
CTR132(X) ;
 W ?(132-$L(X))\2,X
 Q 1
 ;
