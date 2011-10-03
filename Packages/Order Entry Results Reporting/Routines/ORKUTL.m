ORKUTL ; slc/CLA - Utility routine for order checking ;5/21/97  16:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**6**;Dec 17, 1997
ONOFF(ORK,ORKUSR,ORKPT) ;Extrinsic function to check param file determines if
 ; user ORKUSR should receive order check ORK for patient ORKPT. 
 ;ORK      order check ien from file 864.5 (req'd)
 ;ORKUSR   user ien from file 200 (req'd)
 ;ORKPT    patient ien from file 2 (not req'd)
 ;
 N NODE,ORKNAME,ORKUSRN,ORKUSRF,ORKPTN,ORKLOC,ORKLOCN,ORKLOCF
 N ORKSRV,ORKSRVN,ORKSRVF,ORKDIVF,ORKSYSF,ORKPKGF
 ;
 ;get order check name:
 S NODE=$G(^ORD(100.8,ORK,0)) S:$L($G(NODE)) ORKNAME=$P(NODE,U)
 ;
 ;get user name:
 S NODE=$G(^VA(200,ORKUSR,0)) S:$L($G(NODE)) ORKUSRN=$P(NODE,U)
 ;
 ;get patient name:
 S:$L($G(ORKPT)) NODE=$G(^DPT(ORKPT,0)) S:$L($G(NODE)) ORKPTN=$P(NODE,U)
 ;
 ;get patient's location (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 I +$G(ORKPT)>0 D
 .N DFN S DFN=ORKPT,VA200="" D OERR^VADPT
 .S ORKLOC=+$G(^DIC(42,+VAIN(4),44)) I +$G(ORKLOC)>0 D
 ..S ORKLOCN=$P(^SC(+ORKLOC,0),U)
 K VA200,VAIN
 ;
 ;get user's service/section:
 S ORKSRV=$G(^VA(200,ORKUSR,5)) I +ORKSRV>0 S ORKSRV=$P(ORKSRV,U) D
 .S NODE=$G(^DIC(49,ORKSRV,0)) S:$L($G(NODE)) ORKSRVN=$P(NODE,U)
 ;
 S ORK="`"_ORK
 ;
 ;get user's flag:
 S ORKUSRF=$$GET^XPAR("USR.`"_+$G(ORKUSR),"ORK PROCESSING FLAG",ORK,"B")
 Q:$L($G(ORKUSRF)) $S($P(ORKUSRF,U)="D":"OFF",1:"ON")_"^User value is "_$P(ORKUSRF,U,2)
 ;
 ;get patient location flag:
 I +$G(ORKLOC)>0 D
 .S ORKLOCF=$$GET^XPAR("LOC.`"_+$G(ORKLOC),"ORK PROCESSING FLAG",ORK,"B")
 Q:$L($G(ORKLOCF)) $S($P(ORKLOCF,U)="D":"OFF",1:"ON")_"^Pt's location "_ORKLOCN_" value is "_$P(ORKLOCF,U,2)
 ;
 ;get user's service flag:
 I +$G(ORKSRV)>0 D
 .S ORKSRVF=$$GET^XPAR("SRV.`"_+$G(ORKSRV),"ORK PROCESSING FLAG",ORK,"B")
 Q:$L($G(ORKSRVF)) $S($P(ORKSRVF,U)="D":"OFF",1:"ON")_"^User's service "_ORKSRVN_" value is "_$P(ORKSRVF,U,2)
 ;
 ;get user's division flag:
 S ORKDIVF=$$GET^XPAR("DIV","ORK PROCESSING FLAG",ORK,"B")
 Q:$L($G(ORKDIVF)) $S($P(ORKDIVF,U)="D":"OFF",1:"ON")_"^Division value is "_$P(ORKDIVF,U,2)
 ;
 ;get system flag:
 S ORKSYSF=$$GET^XPAR("SYS","ORK PROCESSING FLAG",ORK,"B")
 Q:$L($G(ORKSYSF)) $S($P(ORKSYSF,U)="D":"OFF",1:"ON")_"^System value is "_$P(ORKSYSF,U,2)
 ;
 ;get OE/RR package-exported flag:
 S ORKPKGF=$$GET^XPAR("PKG","ORK PROCESSING FLAG",ORK,"B")
 Q:$L($G(ORKPKGF)) $S($P(ORKPKGF,U)="D":"OFF",1:"ON")_"^OERR value is "_$P(ORKPKGF,U,2)
 ;
 Q "ON^No value found"
USRCHKS(ORKUSR) ; generate a list of order checks indicating user's recip status
 I +$G(ORKUSR)<1 S ORKUSR=DUZ
 N ORY,ORYI,ORKY,ORKIEN,ORKNAM,NODE,ORX,DESC,HDR
 S ORYI=1
 ;
 ;prompt for additional information:
 W !!,"Would you like help understanding the list of order checks" S %=2 D YN^DICN I %=1 D HLPMSG
 K %
 ;
 ;see if order checking system is disabled:
 S ORX=$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE",1,"I")
 I ORX="D" D
 .S ORY(ORYI)="Order Checking is disabled. No order checks will be processed or displayed."
 .S NODE=$G(^VA(200,ORKUSR,0)) S:$L($G(NODE)) HDR="Order Check List for "_$P(NODE,U)
 .S DESC="Order check possibilities for a user"
 .D OUTPUT(.ORY,DESC,HDR)
 Q:ORX="D"
 ;
 W !!,"This will take a moment or two, please stand by."
 ;
 S ORY(ORYI)="Order Check                       ON/OFF For This User and Why",ORYI=ORYI+1
 S ORY(ORYI)="--------------------------------  ---------------------------------------------",ORYI=ORYI+1
 ;
 ;loop thru all order checks and determine recipient status:
 S ORKNAM="" F  S ORKNAM=$O(^ORD(100.8,"B",ORKNAM)) Q:ORKNAM=""  D
 .S ORKIEN=0,ORKIEN=$O(^ORD(100.8,"B",ORKNAM,ORKIEN)) I +$G(ORKIEN)>0 D
 ..S ORKY(ORKNAM)=ORKIEN
 ..S ORX=$$ONOFF(ORKIEN,ORKUSR,"") I $L($G(ORX)) D
 ...W "."
 ...S ORKNAM=$E(ORKNAM_"                                ",1,32)
 ...S ORY(ORYI)=ORKNAM_"  "_$E($P(ORX,U)_"   ",1,5)_$P(ORX,U,2),ORYI=ORYI+1
 ;
 S ORYI=ORYI+1,ORY(ORYI)="",ORYI=ORYI+1,ORY(ORYI)="",ORYI=ORYI+1
 S DESC="Order check possibilities for a user"
 S NODE=$G(^VA(200,ORKUSR,0)) S:$L($G(NODE)) HDR="Order Check List for "_$P(NODE,U)
 D OUTPUT(.ORY,DESC,HDR)
 Q
HLPMSG ;display/print help message for a user's order checks
 N ORY,ORYI
 S ORYI=1
 S ORY(ORYI)="The delivery of order checks is determined from values set for Users,",ORYI=ORYI+1
 S ORY(ORYI)="Inpatient Locations, Service/Sections, Hospital Divisions, Computer System and",ORYI=ORYI+1
 S ORY(ORYI)="OERR. Possible values include 'Enabled' and 'Disabled'. These values indicate",ORYI=ORYI+1
 S ORY(ORYI)="a User's, Location's, Service/Section's, Division's, System's and OERR's",ORYI=ORYI+1
 S ORY(ORYI)="desire for the order check to be 'Enabled' (displayed under most",ORYI=ORYI+1
 S ORY(ORYI)="circumstances) or 'Disabled' (normally not displayed.)",ORYI=ORYI+1
 S ORY(ORYI)="",ORYI=ORYI+1
 S ORY(ORYI)="All values, except the OERR (Order Entry) value, can be set by IRM",ORYI=ORYI+1
 S ORY(ORYI)="or Clinical Coordinators. Individual users can set their 'Enabled/Disabled'",ORYI=ORYI+1
 S ORY(ORYI)="values for each specific order check via the 'Enable/Disable My Order Checks'",ORYI=ORYI+1
 S ORY(ORYI)="option under the Personal Preferences and Order Check Management for Users.",ORYI=ORYI+1
 S ORY(ORYI)="'ON' indicates the user will receive the order check under normal conditions.",ORYI=ORYI+1
 S ORY(ORYI)="'OFF' indicates the user normally will not receive the order check.",ORYI=ORYI+1
 S ORY(ORYI)="Order check recipient determination can also be influenced by patient",ORYI=ORYI+1
 S ORY(ORYI)="location (inpatients only.) This list does not consider patient location",ORYI=ORYI+1
 S ORY(ORYI)="when calculating the ON/OFF value for an order check because a patient is",ORYI=ORYI+1
 S ORY(ORYI)="not known when the option is selected.",ORYI=ORYI+1
 S ORY(ORYI)="",ORYI=ORYI+1,ORY(ORYI)="",ORYI=ORYI+1
 S DESC="Help Message - order check possibilities for a user"
 S HDR="Order Check List Help Message"
 D OUTPUT(.ORY,DESC,HDR)
 Q
OUTPUT(ORY,ORKDESC,ORKHDR) ;prompt for device and send report
 N POP,ORBHDR
 N ZTRTN,ZTSAVE,ZTDESC
 ;prompt for device:
 S %ZIS="Q"  ;prompt for Queueing
 D ^%ZIS
 Q:$G(POP)>0
 I $D(IO("Q")) D  ;queue the report
 .S ZTRTN="PRINT^ORB3U1"
 .S ORBHDR=ORKHDR
 .S ZTSAVE("ORY(")="",ZTSAVE("ORBHDR")=""
 .S ZTDESC=ORKDESC
 .D ^%ZTLOAD
 .I $D(ZTSK)[0 W !!?5,"Report canceled!"
 .E  W !!?5,"Report queued."
 .D HOME^%ZIS
 K %ZIS
 I $D(IO("Q")) K IO("Q") Q
PRINT ;print body of List User's Order checks Report
 N END,PAGE,I,X
 S (END,PAGE,I)=0
 U IO
 D @("HDR"_(2-($E(IOST,1,2)="C-")))
 F  S I=$O(ORY(I)) Q:I=""!(END=1)  D
 .D HDR:$Y+5>IOSL
 .Q:END=1
 .W !,ORY(I)
 I END=1 W !!,"           - Report Interrupted -",!
 E  W "           - End of Report -",!
 I ($E(IOST,1,2)="C-") W !,"Press RETURN to continue: " R X:DTIME
 D ^%ZISC
 D:$G(ZTSK) KILL^%ZTLOAD
 Q
HDR ;print header of report
 I PAGE,($E(IOST,1,2)="C-") D
 .W !,"Press RETURN to continue or '^' to exit: "
 .R X:DTIME S END='$T!(X="^")
 Q:END=1
HDR1 W:'($E(IOST,1,2)='"C-"&'PAGE) @IOF
HDR2 S PAGE=PAGE+1 W ?20,ORKHDR
 W ?(IOM-10),"Page: ",$J(PAGE,3),!!
 Q
