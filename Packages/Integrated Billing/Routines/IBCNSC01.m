IBCNSC01 ;ALB/NLR - INSURANCE COMPANY EDIT ;6/1/05 10:06am
 ;;2.0;INTEGRATED BILLING;**52,137,191,184,232,320,349,371,399,416,432,494,519,547,592,608,668,687,713**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PARAM ; -- Insurance company parameters region
 N OFFSET,START,IBCNS0,IBCNS03,IBCNS06,IBCNS08,IBCNS13,IBCNS3,IBHPD
 S IBCNS0=$G(^DIC(36,+IBCNS,0)),IBCNS3=$G(^(3))
 S IBCNS03=$P(IBCNS0,"^",3),IBCNS06=$P(IBCNS0,"^",6),IBCNS08=$P(IBCNS0,"^",8)
 S IBCNS13=$G(^DIC(36,+IBCNS,.13))
 S START=1,OFFSET=2
 D SET^IBCNSP(START,OFFSET+25," Billing Parameters ",IORVON,IORVOFF)
 ;
 D SET^IBCNSP(START+1,OFFSET+1,"Signature Required?: "_$S(+IBCNS03:"YES",1:"NO"))
 D SET^IBCNSP(START+2,OFFSET+10,"Reimburse?: "_$E($$EXPAND^IBTRE(36,1,$P(IBCNS0,"^",2)),1,21))
 D SET^IBCNSP(START+3,OFFSET+3,"Mult. Bedsections: "_$S(+IBCNS06:"YES",IBCNS06=0:"NO",1:""))
 D SET^IBCNSP(START+4,OFFSET+6,"One Opt. Visit: "_$S(+IBCNS08:"YES",1:"NO"))
 D SET^IBCNSP(START+5,OFFSET+4,"Diff. Rev. Codes: "_$P(IBCNS0,"^",7))
 D SET^IBCNSP(START+6,OFFSET+1,"Amb. Sur. Rev. Code: "_$P(IBCNS0,"^",9))
 D SET^IBCNSP(START+7,OFFSET+1,"Rx Refill Rev. Code: "_$P(IBCNS0,"^",15))
 D SET^IBCNSP(START+8,OFFSET+3,"Filing Time Frame: "_$P(IBCNS0,"^",12)_$S(+$P(IBCNS0,"^",18):" ("_$$FTFN^IBCNSU31(,+IBCNS)_")",1:""))
 ;
 S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET+4,"Type Of Coverage: "_$$EXPAND^IBTRE(36,.13,+$P(IBCNS0,U,13)))
 D SET^IBCNSP(START+2,OFFSET+7,"Billing Phone: "_$P(IBCNS13,"^",2))
 D SET^IBCNSP(START+3,OFFSET+2,"Verification Phone: "_$P(IBCNS13,"^",4))
 D SET^IBCNSP(START+4,OFFSET+2,"Precert Comp. Name: "_$P($G(^DIC(36,+$P(IBCNS13,"^",9),0)),"^",1))
 D SET^IBCNSP(START+5,OFFSET+7,"Precert Phone: "_$$PHONE(IBCNS13))
 I +IBCNS3=2 D SET^IBCNSP(START+6,OFFSET,"Max # Test Bills/Day: "_$P(IBCNS3,U,6))
 ;
 S START=11,OFFSET=2
 D SET^IBCNSP(START,OFFSET+28," EDI Parameters ",IORVON,IORVOFF)
 ;/IB*2*608 (vd) for US1909 changed the line below from "TEST ONLY" to "YES-TEST"
 ;D SET^IBCNSP(START+1,OFFSET+13,"Transmit?: "_$S(+IBCNS3=1:"YES-LIVE",+IBCNS3=2:"TEST ONLY",$P(IBCNS3,U,1)="":"",1:"NO"))
 D SET^IBCNSP(START+1,OFFSET+13,"Transmit?: "_$S(+IBCNS3=1:"YES-LIVE",+IBCNS3=2:"YES-TEST",$P(IBCNS3,U,1)="":"",1:"NO"))
 D SET^IBCNSP(START+2,OFFSET+1,"Inst Payer Primary ID: "_$P(IBCNS3,U,4))
 ;
 ;WCJ;IB*2.0*547; Lots o Changes below to include new Alternate Primary ID
 N IBAC,IBACND,LOOP
 S IBACMAX=0
 F IBACND=15,16 D
 .S LOOP=0 F  S LOOP=$O(^DIC(36,+IBCNS,IBACND,LOOP)) Q:'+LOOP  D
 ..S IBAC(IBACND,"CT")=$G(IBAC(IBACND,"CT"))+1 I IBAC(IBACND,"CT")>IBACMAX S IBACMAX=IBAC(IBACND,"CT")
 ..S IBAC(IBACND,IBAC(IBACND,"CT"))=$P($G(^DIC(36,+IBCNS,IBACND,LOOP,0)),U,1,2)
 ;
 S LOOP=0 F  S LOOP=$O(IBAC(15,LOOP)) Q:'LOOP  D
 .D SET^IBCNSP(START+2+(LOOP*2-1),OFFSET,"Alt-I Payer Prim ID Type: "_$$GET1^DIQ(355.98,+$P($G(IBAC(15,LOOP)),U),.01))
 .D SET^IBCNSP(START+2+(LOOP*2),OFFSET,"Alt-Inst Payer Prim ID: "_$P($G(IBAC(15,LOOP)),U,2))
 ;
 D SET^IBCNSP(START+3+(2*IBACMAX),OFFSET,"Inst Payer Sec ID Qual: "_$$GET1^DIQ(36,+IBCNS,6.01))
 D SET^IBCNSP(START+4+(2*IBACMAX),OFFSET+5,"Inst Payer Sec ID: "_$$GET1^DIQ(36,+IBCNS,6.02))
 D SET^IBCNSP(START+5+(2*IBACMAX),OFFSET,"Inst Payer Sec ID Qual: "_$$GET1^DIQ(36,+IBCNS,6.03))
 D SET^IBCNSP(START+6+(2*IBACMAX),OFFSET+5,"Inst Payer Sec ID: "_$$GET1^DIQ(36,+IBCNS,6.04))
 ;
 ;JWS;IB*2.0*592;Dental Payer ID, moved UMO ID and HPD down 1
 D SET^IBCNSP(START+7+(2*IBACMAX),OFFSET+7,"Dental Payer ID: "_$P(IBCNS3,U,15))
 D SET^IBCNSP(START+8+(2*IBACMAX),OFFSET+12,"Bin Number: "_$P($G(^DIC(36,+IBCNS,3)),"^",3))
 ;IB*2.0*547;WCJ Added and bumped HPID down
 D SET^IBCNSP(START+9+(2*IBACMAX),OFFSET+10,"UMO (278) ID: "_$P($G(^DIC(36,+IBCNS,7)),U))
 ;ib*2.0*519
 S IBHPD=$$HPD^IBCNHUT1(+IBCNS)
 D SET^IBCNSP(START+10+(2*IBACMAX),OFFSET+13,$P($$HOD^IBCNHUT1(IBHPD),U,2)_": "_IBHPD)
 ;
 S OFFSET=41
 D SET^IBCNSP(START+1,OFFSET+8," Insurance Type: "_$$EXPAND^IBTRE(36,3.09,+$P(IBCNS3,U,9)))
 D SET^IBCNSP(START+2,OFFSET+1," Prof Payer Primary ID: "_$P(IBCNS3,U,2))
 ;
 S LOOP=0 F  S LOOP=$O(IBAC(16,LOOP)) Q:'LOOP  D
 .D SET^IBCNSP(START+2+(LOOP*2-1),OFFSET+1,"Alt-P Payer Prim ID Type: "_$$GET1^DIQ(355.98,+$P($G(IBAC(16,LOOP)),U),.01))
 .D SET^IBCNSP(START+2+(LOOP*2),OFFSET+1,"Alt-Prof Payer Prim ID: "_$P($G(IBAC(16,LOOP)),U,2))
 ;
 D SET^IBCNSP(START+3+(2*IBACMAX),OFFSET," Prof Payer Sec ID Qual: "_$$GET1^DIQ(36,+IBCNS,6.05))
 D SET^IBCNSP(START+4+(2*IBACMAX),OFFSET+5," Prof Payer Sec ID: "_$$GET1^DIQ(36,+IBCNS,6.06))
 D SET^IBCNSP(START+5+(2*IBACMAX),OFFSET," Prof Payer Sec ID Qual: "_$$GET1^DIQ(36,+IBCNS,6.07))
 D SET^IBCNSP(START+6+(2*IBACMAX),OFFSET+5," Prof Payer Sec ID: "_$$GET1^DIQ(36,+IBCNS,6.08))
 ;IB*2.0*432/TAZ Added fields 6.09 and 6.1
 D SET^IBCNSP(START+8+(2*IBACMAX),OFFSET-3," Prnt Sec/Tert Auto Claims: "_$$GET1^DIQ(36,+IBCNS,6.09))
 D SET^IBCNSP(START+9+(2*IBACMAX),OFFSET-5," Prnt Med Sec Claims w/o MRA: "_$$GET1^DIQ(36,+IBCNS,6.1))
 Q
 ;
PHONE(IBCNS13) ; -- Compute precert company phone
 N IBX,IBSAVE,IBCNT S IBX=""
 I '$P(IBCNS13,"^",9) S IBX=$P(IBCNS13,"^",3) G PHONEQ
REDOX S IBSAVE=+$P(IBCNS13,"^",9)
 S IBCNT=$G(IBCNT)+1
 ; -- if you process the same co. more than once you are in an infinite loop
 I $D(IBCNT(IBCNS)) G PHONEQ
 S IBCNT(IBCNS)=""
 S IBCNS13=$G(^DIC(36,+$P(IBCNS13,"^",9),.13))
 S IBX=$P(IBCNS13,"^") S:$L($P(IBCNS13,"^",3)) IBX=$P(IBCNS13,"^",3)
 ; -- if process the same co. more than once you are in an infinite loop
 I $P(IBCNS13,"^",9),$P(IBCNS13,"^",9)'=IBSAVE G REDOX
PHONEQ Q IBX
 ;
MAIN ; -- Insurance company main address
 N OFFSET,START,IBCNS11,IBCNS13,IBADD
 S IBCNS11=$G(^DIC(36,+IBCNS,.11))
 S IBCNS13=$G(^DIC(36,+IBCNS,.13))
 ;
 ;S START=21,OFFSET=25
 S START=22+(2*IBACMAX),OFFSET=25
MAINAD ; KDM US2487 IB*2.0*592  call in tag from IBCNSI
 D SET^IBCNSP(START,OFFSET," Main Mailing Address ",IORVON,IORVOFF)
 S OFFSET=2
 D SET^IBCNSP(START+1,OFFSET,"       Street: "_$P(IBCNS11,"^",1)) S IBADD=1
 D SET^IBCNSP(START+2,OFFSET,"     Street 2: "_$P(IBCNS11,"^",2)) S IBADD=2
 D SET^IBCNSP(START+3,OFFSET,"     Street 3: "_$P(IBCNS11,"^",3)) S IBADD=3
 ; D SET^IBCNSP(START+4,OFFSET,"Claim Off. ID: "_$P(IBCNS11,U,11))
 S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"   City/State: "_$E($P(IBCNS11,"^",4),1,15)_$S($P(IBCNS11,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCNS11,"^",5),0)),"^",2)_" "_$E($P(IBCNS11,"^",6),1,5))
 D SET^IBCNSP(START+2,OFFSET,"        Phone: "_$P(IBCNS13,"^",1))
 D SET^IBCNSP(START+3,OFFSET,"          Fax: "_$P(IBCNS11,"^",9))
 Q
 ;
PAYER ; This procedure builds the display for the payer associated with
 ; this insurance company.
 ; /vd-IB-2-687 - The following module has been restructured with new code to modify
 ;                the display for how the payer and the "EIV" and "IIU" payer
 ;                applications are displayed.
 ; - 08/31/20 - IIU project
 ; - 2/4/13 - remove ePharmacy references (IB*2*494)
 ; - 9/9/09 - eIV updated
 ; ESG - 7/29/02 - IIV project
 ;
 N APP,APPEIV,APPIIU,APPNAME,ARRAYEIV,ARRAYIIU,DEACTV8D,IBDATA,IBLINE,IENEIV,IENIIU,OFFSET,PIEN,PEINEIV,PEINIIU,START,TITLE
 S PIEN=+$$GET1^DIQ(36,+IBCNS,3.10,"I"),DEACTV8D=0
 S APPEIV=$$FIND1^DIC(365.13,,,"EIV"),APPIIU=$$FIND1^DIC(365.13,,,"IIU")
 ;
 S IBDATA=$G(^IBE(365.12,+PIEN,0))
 S IENEIV=+$$PYRAPP^IBCNEUT5("EIV",+PIEN)   ; Get the ien of the EIV application
 S IENIIU=+$$PYRAPP^IBCNEUT5("IIU",+PIEN)   ; Get the ien of the IIU application
 ;
 S (PEINEIV,PEINIIU)=""
 I IENEIV D
 . D PAYER^IBCNINSU(+PIEN,"EIV","*","I",.ARRAYEIV)   ; Get the Payer's EIV data.
 . S PEINEIV=$O(ARRAYEIV(365.121,""))
 I IENIIU D
 . D PAYER^IBCNINSU(+PIEN,"IIU","*","I",.ARRAYIIU)   ; Get the Payer's IIU data.
 . S PEINIIU=$O(ARRAYIIU(365.121,""))
 ;
 ; Display Payer data
 S START=$O(^TMP("IBCNSC",$J,""),-1)+1
 S IB1ST("PAYER")=START
 S TITLE=" Payer: "_$P($G(IBDATA),U,1)
 S OFFSET=(40-($L(TITLE)/2))\1+1
 D SET^IBCNSP(START,OFFSET,TITLE,IORVON,IORVOFF)
 ; IB*2.0*713/DTG - start add in set for a blank line for undef error when using SL
 D SET^IBCNSP(START+1,2,"") ;blank line
 ; IB*2.0*713/DTG - end add in set for a blank line for undef error when using SL
 D SET^IBCNSP(START+2,5,"VA National ID: "_$P($G(IBDATA),U,2))
 D SET^IBCNSP(START+2,51,"CMS National ID: "_$P($G(IBDATA),U,3))
 ;
 I '$D(ARRAYEIV),'$D(ARRAYIIU) D  Q   ; Quit out if there is no payer data.
 . D SET^IBCNSP(START+4,16,"Payer Application data is not defined!")
 . D SET^IBCNSP(START+5,2,"") ;blank line
 . S IBLINE=START+5
 ;
 S DEACTV8D=+$$PYRDEACT^IBCNINSU(+PIEN)   ; Deactivated status.
 D SET^IBCNSP(START+3,8,"Deactivated: "_$$YESNO(+DEACTV8D))
 S IBLINE=START+3
 ;
 ; If deactivated display date
 I +DEACTV8D D
 . D SET^IBCNSP(IBLINE,50,"Date Deactivated: "_$$FMTE^XLFDT($P($$GET1^DIQ(365.12,PIEN,.08,"I"),"."),"5Z"))
 . S IBLINE=START+3
 ;
 ; Show eIV application data.
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,2,"") ;blank line
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,21,"Payer Application: eIV")   ; IB*2*416 - change external display to be eIV
 I 'IENEIV D
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,16,"Payer Application data is not defined!")
 I +IENEIV D
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,4,"Nationally Enabled: "_$$YESNO(ARRAYEIV(365.121,PEINEIV,.02,"I")))
 . D SET^IBCNSP(IBLINE,51,"FSC Auto-Update: "_$$YESNO(ARRAYEIV(365.121,PEINEIV,4.01,"I")))
 . ;
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,7,"Locally Enabled: "_$$YESNO(ARRAYEIV(365.121,PEINEIV,.03,"I")))
 ;
 ; Show IIU application data.
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,2,"") ;blank line
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,21,"Payer Application: IIU")
 I 'IENIIU D
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,16,"Payer Application data is not defined!")
 I +IENIIU D
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,4,"Nationally Enabled: "_$$YESNO(ARRAYIIU(365.121,PEINIIU,.02,"I")))
 . D SET^IBCNSP(IBLINE,50,"Receive IIU Data: "_$$YESNO(ARRAYIIU(365.121,PEINIIU,5.01,"I")))
 . ;
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,7,"Locally Enabled: "_$$YESNO(ARRAYIIU(365.121,PEINIIU,.03,"I")))
 ;
 ; Two trailing blank lines after payer information display
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,2," ") ; blank line
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,2," ") ; blank line
 Q
 ;/vd - IB-2-687 - End of newly structured code.
 ;
REMARKS ;
 ;
 N OFFSET,START,IBLCNT,IBI
 S START=$O(^TMP("IBCNSC",$J,""),-1)+1,OFFSET=2
 S IB1ST("REM")=START
 ;
 D SET^IBCNSP(START,OFFSET," Remarks ",IORVON,IORVOFF)
 S (IBLCNT,IBI)=0 F  S IBI=$O(^DIC(36,+IBCNS,11,IBI)) Q:IBI<1  D
 . S IBLCNT=IBLCNT+1
 . D SET^IBCNSP(START+IBLCNT,OFFSET,"  "_$E($G(^DIC(36,+IBCNS,11,IBI,0)),1,80))
 . Q
 D SET^IBCNSP(START+IBLCNT+1,OFFSET," ")   ; blank line after remarks
 Q
 ;
SYN ;
 N OFFSET,START,SYN,SYNOI
 S START=$O(^TMP("IBCNSC",$J,""),-1)+1,OFFSET=2
 S IB1ST("SYN")=START
 D SET^IBCNSP(START,OFFSET," Synonyms ",IORVON,IORVOFF)
 S SYN="" F SYNOI=1:1:8 S SYN=$O(^DIC(36,+IBCNS,10,"B",SYN)) Q:SYN=""  D SET^IBCNSP(START+SYNOI,OFFSET,$S(SYNOI>7:"  ...edit to see more...",1:"  "_SYN))
 Q
 ;
YESNO(VAL) ;Translate to a YES or NO value. - /vd - IB*2.0*687
 ; INPUT:   VAL = Either 0 or 1
 ; OUTPUT:  'YES' (for VAL=1), 'NO' (for VAL=0)
 Q $S(VAL=1:"YES",1:"NO")
 ;
