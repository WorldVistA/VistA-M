FBAAV3 ;AISC/GRR-CREATE & ELECTRONICALLY TRANSMIT TRANSACTIONS FOR TRAVEL PAYMENTS ;2/8/2005
 ;;3.5;FEE BASIS;**3,89,116**;JAN 30, 1995;Build 30
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DETT ; process a travel batch
 S FBTXT=0
 ; HIPAA 5010 - line items that have 0.00 amount paid are now required to go to Central Fee
 ;F K=0:0 S K=$O(^FBAAC("AD",J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AD",J,K,L)) Q:L'>0  S Y(0)=$G(^FBAAC(K,3,L,0)) I Y(0)]"",+$P(Y(0),U,3) D
 F K=0:0 S K=$O(^FBAAC("AD",J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AD",J,K,L)) Q:L'>0  S Y(0)=$G(^FBAAC(K,3,L,0)) I Y(0)]"" D
 .S FBPICN=K_U_L
 .I 'FBTXT S FBTXT=1 D NEWMSG^FBAAV01,STORE^FBAAV01,UPD^FBAAV0
 .D GOT
 D:FBTXT XMIT^FBAAV01 Q
GOT ; process a travel line item
 N DFN,FBPNAMX
 S FBTD=$$AUSDT($P(Y(0),U))
 S FBAP=$$AUSAMT($P(Y(0),"^",3),8)
 S DFN=K
 Q:'DFN
 Q:'$D(^DPT(DFN,0))
 ; Note: Prior to the following line Y(0) = 0 node of subfile #162.04
 ;       After the line, Y(0) will = 0 node of file #2
 S Y(0)=^DPT(DFN,0)
 D PAT^FBAAUTL2
 S FBPNAMX=$$HL7NAME^FBAAV4(DFN) ; formatted patient name
 S FBSTR="T"_FBAASN_FBSSN_"T"_FBPNAMX_FBAP_FBAAON_FBTD_"0"_$E(PAD,1,8)
 S FBSTR=FBSTR_$$PADZ^FBAAV01(FBPICN,30)_FBTD_"$"
 D STORE^FBAAV01
 K FBPICN
 Q
 ;
AUSDT(FBDT) ;called to format date from VA FileMan internal to YYYYMMDD
 ; if input date is blank or invalid, eight spaces will be returned
 ;
 N FBRET
 S:FBDT FBRET=$$FMTHL7^XLFDT($P(FBDT,"."))
 S:$G(FBRET)=""!($G(FBRET)<0) FBRET="        "
 Q FBRET
 ;
AUSAMT(FBAMT,FBL,FBS) ; called to format signed dollar amount for Austin
 ; input
 ;   FBAMT - dollar amount
 ;   FBL   - (optional) length of return sting 
 ;   FBS   - (optional) =true(1) if return value could be negative (-)
 ;           default is false (0)
 ; result
 ;   string value, right justified, 0 padded, decimal point removed,
 ;   with rightmost 2 numeric characters the cents
 ;   if FBS true then rightmost character indicate the sign (' ' or '-')
 ;   example with FBS false: 12.41 with length 8 would return '00001241'
 ;   example with FBS true:  12.41 with length 9 would return '00001241 '
 ;   example with FBS true: -12.41 with length 9 would return '00001241-'
 ;
 N FBRET
 ;
 ; use absolute value
 S FBRET=$S(FBAMT<0:-FBAMT,1:FBAMT)
 ;
 ; format with 2 decimals places
 S FBRET=$FN(FBRET,"",2)
 ;
 ; remove the decimal point
 S FBRET=$TR(FBRET,".","")
 ;
 ; add the suffix denoting the sign when applicable (when FBS true)
 S FBRET=FBRET_$S('$G(FBS):"",FBAMT<0:"-",1:" ")
 ;
 ; right justify and 0 pad
 S FBRET=$$RJ^XLFSTR(FBRET,$G(FBL),"0")
 ;
 ; return result
 Q FBRET
 ;
 ;FBAAV3
