IBTOBI4 ;ALB/AAS - CLAIMS TRACKING BILLING INFORMATION PRINT ;27-OCT-93
 ;;2.0;INTEGRATED BILLING;**91,125,51,210,266,389**;21-MAR-94;Build 6
 ;
CLIN ; -- output clinical information
 N IBOE,DGPM
 Q:$D(IBCTHDR)
 ;
 I $P(IBETYP,"^",3)=1 S DGPM=$P(^IBT(356,+IBTRN,0),"^",5) I 'DGPM Q
 I $P(IBETYP,"^",3)=2 S IBOE=$P(^IBT(356,+IBTRN,0),"^",4)
 F IBTAG="DIAG","PROC","PROV" D @IBTAG Q:IBQUIT
 Q
 ;
DIAG ; -- print diagnosis information
 I '$G(DGPM),('$G(IBOE)) Q
 Q:$P(IBETYP,"^",3)>2
 I ($Y+9)>IOSL D HDR^IBTOBI Q:IBQUIT
DIAG1 W !,"  Diagnosis Information "
 N IBXY,SDDXY,ICDVDT
 I $G(DGPM) D SET^IBTRE3(+IBTRN) W:'$D(IBXY) !?6,"Nothing on File" D:$D(IBXY) LIST^IBTRE3(.IBXY)
 I $G(IBOE) D SET^SDCO4(IBOE) W:'$D(SDDXY) !?6,"Nothing on File" I $D(SDDXY) S ICDVDT=$$TRNDATE^IBACSV(+IBTRN) D LIST^SDCO4(.SDDXY)
 ; 
 D:$G(DGPM) DRG
 W:'IBQUIT !?4,$TR($J(" ",IOM-8)," ","-"),!
 Q
 ;
PROC ; -- print procedure information
 Q:$P(IBETYP,"^",3)>2
 I ($Y+9)>IOSL D HDR^IBTOBI Q:IBQUIT
PROC1 W !,"  Procedure Information "
 ;
 N IBXY,IBCNT,IBVAL,IBCBK S IBCNT=0
 I $G(DGPM) D SET^IBTRE4(+IBTRN) W:'$D(IBXY) !?6,"Nothing on File" D:$D(IBXY) LIST^IBTRE4(.IBXY)
 I '$G(DGPM) D  W:'$D(IBXY) !?6,"Nothing on File" D:$D(IBXY) LIST(.IBXY)
 .S IBDT=$P($P(IBTRND,"^",6),".")
 .;
 .S IBVAL("DFN")=DFN,IBVAL("BDT")=IBDT-.000001,IBVAL("EDT")=IBDT\1_".99"
 .; Only want to extract procedures from parent encounters to avoid dups
 .S IBCBK="I '$P(Y0,U,6) D GETPROC^IBTOBI4(Y,Y0,.IBCNT,.IBXY)"
 .D SCAN^IBSDU("PATIENT/DATE",.IBVAL,"",IBCBK) K ^TMP("DIERR",$J)
 ;
 W:'IBQUIT !?4,$TR($J(" ",IOM-8)," ","-"),!
 Q
 ;
GETPROC(IBOE,IBOE0,IBCNT,IBXY) ; output:  IBXY(cnt) = CPT IFN ^ DT/TM ^ Mod,Mod ^ Encounter Provider (#1204)
 N I2,IBCPT,IBCPTS,IBZERR,IBM,IBMODS
 D GETCPT^SDOE(IBOE,"IBCPTS","IBZERR")
 Q:'$O(IBCPTS(0))  ;No procedures for this encounter
 S I2=0
 F  S I2=$O(IBCPTS(I2)) Q:'I2  F Z=1:1:$P(IBCPTS(I2),U,16) D
 . S IBMODS="",IBM=0
 . F  S IBM=$O(IBCPTS(I2,1,IBM)) Q:'IBM  S IBMODS=$S(IBMODS="":"",1:",")_$G(IBCPTS(I2,1,IBM,0))
 . S IBCNT=IBCNT+1,IBXY(IBCNT)=$P(IBCPTS(I2),U)_U_+IBOE0_U_IBMODS_U_$P($G(IBCPTS(I2,12)),U,4)
 Q
 ;
PROV ; -- print provider information
 I '$G(DGPM),('$G(IBOE)) Q
 Q:$P(IBETYP,"^",3)>2
 I ($Y+9)>IOSL D HDR^IBTOBI Q:IBQUIT
PROV1 W !,"  Provider Information "
 N IBXY,SDPRY
 I $G(DGPM) D SET^IBTRE5(+IBTRN) W:'$D(IBXY) !?6,"Nothing on File" D:$D(IBXY) LIST^IBTRE5(.IBXY)
 I $G(IBOE) D SET^SDCO3(IBOE) W:'$D(SDPRY) !?6,"Nothing on File" D:$D(SDPRY) LIST^SDCO3(.SDPRY)
 W:'IBQUIT !?4,$TR($J(" ",IOM-8)," ","-"),!
 Q
 ;
LIST(IBXY) ; -- list procedures array
 ; Input  -- IBXY     Diagnosis Array Subscripted by a Number
 ; Output -- List Diagnosis Array
 N I,IBXD,IBMODS,J,IBM,IBDATE
 W !
 S I=0 F  S I=$O(IBXY(I)) Q:'I  D
 . S IBDATE=$P(IBXY(I),U,2)
 . S IBXD=$$PRCD^IBCEF1(+IBXY(I)_";ICPT(",1,IBDATE)
 . W !?2,I,"  ",$P(IBXD,U,2),?15,$E($P(IBXD,U,3),1,40),?60,$$DAT1^IBOUTL(IBDATE,"2P")
 . S IBMODS=$$MODLST^IBEFUNC2($P(IBXY(I),U,3),1,.IBMODS,IBDATE)
 . I IBMODS'="" F J=1:1:$L(IBMODS,",") W !,?15,$P(IBMODS,",",J),?20,$P($G(IBMODS(1)),",",J)
 Q
 ;
DRG ; -- print drgs.
 I '$G(DGPM) Q
 Q:$P(IBETYP,"^",3)>1
 I ($Y+9)>IOSL D HDR^IBTOBI Q:IBQUIT
DRG1 W !!,"  Associated Interim DRG Information "
 N IBX,IBDTE,IBDRG
 I $G(DGPM) D
 .I '$O(^IBT(356.93,"AMVD",DGPM,0)) W !?6,"Nothing on File" Q
 .S IBDTE=0 F  S IBDTE=$O(^IBT(356.93,"AMVD",DGPM,IBDTE)) Q:'IBDTE  S IBDRG=0 F  S IBDRG=$O(^IBT(356.93,"AMVD",DGPM,IBDTE,IBDRG)) Q:'IBDRG  D
 ..S IBX=$G(^IBT(356.93,IBDRG,0)) Q:IBX=""
 ..W !?5,$$DAT1^IBOUTL($P(IBX,"^",3)),?16,+IBX," - ",$$DRGTD^IBACSV(+IBX,$P(IBX,"^",3))
 ..W !?21," Estimate ALOS: "_$J($P(IBX,"^",4),4,1)
 ..W ?45," Days Remaining: "_$J($P(IBX,"^",5),2)
 Q
 ;
4 ; -- Visit region for prosthetics
 N IBDA,IBRMPR S IBDA=$P(IBTRND,"^",9) D PRODATA^IBTUTL1(IBDA)
 S IBD(2,1)="          Item: "_$P($$PIN^IBCSC5B(+IBDA),U,2)
 S IBD(3,1)="   Description: "_$G(IBRMPR(660,+IBDA,24,"E"))
 S IBD(4,1)="      Quantity: "_$J($G(IBRMPR(660,+IBDA,5,"E")),4)
 S IBD(5,1)="    Total Cost: $"_$G(IBRMPR(660,+IBDA,14,"E"))
 S IBD(6,1)="   Transaction: "_$G(IBRMPR(660,+IBDA,2,"E"))
 S IBD(7,1)="        Vendor: "_$G(IBRMPR(660,+IBDA,7,"E"))
 S IBD(8,1)="        Source: "_$G(IBRMPR(660,+IBDA,12,"E"))
 S IBD(9,1)=" Delivery Date: "_$G(IBRMPR(660,+IBDA,10,"E"))
 S IBD(10,1)="       Remarks: "_$G(IBRMPR(660,+IBDA,16,"E"))
 S IBD(11,1)=" Return Status: "_$G(IBRMPR(660,+IBDA,17,"E"))
 Q
