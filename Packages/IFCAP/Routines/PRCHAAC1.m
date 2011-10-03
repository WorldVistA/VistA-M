PRCHAAC1 ;WIFO/CR-CONT. OF IFCAP HL7 MESSAGE TO AUSTIN ;3/4/05 11:43 AM
 ;;5.1;IFCAP;**79,105**;Oct 20, 2000;Build 4
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is called from the routine PRCHAAC.
 ; Set up HL7 environment for message.
 K HLA,HL,HLFS,HLCS,HLRS
 N PRCAPPO,PRCPPA,PRCERR,PRCMID,PRCMSG,PRCSEG,PRCSUB,PRCPROT,PRCRSULT,PRCOPTNS
 S PRCDUZ=$G(DUZ) I +PRCDUZ'>0 D EN^DDIOL("User undefined","","!!?5") Q 0  ;DUZ is system-supplied
 S PRCPROT="PRC_IFCAP_01_EV_AAC"
 D INIT^HLFNC2(PRCPROT,.HL)
 I $G(HL) D  Q 0  ;tell user if there was an error
 . S PRCMSG=0
 . I $P(HL,"^",2)]"" D
 .. D:'$D(ZTQUEUED) EN^DDIOL("Error: "_$P(HL,"^",2)_" occurred. Please try later.")
 ;
 S HLFS=$G(HL("FS"))    ;field separator
 S HLCS=$E(HL("ECH"),1) ;component separator
 S HLRS=$E(HL("ECH"),2) ;repetition separator
 ;
 ;======== MFI Segment ===========
 S PRCSEG="MFI"_HLFS_"CDM"_HLFS_HLFS_"UPD"_HLFS_HLFS_HLFS_"AL"
 S HLA("HLS",1)=PRCSEG
 ;
 ;======== MFE Segment ===========
 S PRCSEG="MFE"_HLFS_"MAD"_HLFS_HLFS
 S $P(PRCSEG,HLFS,5)="V"_PRCROOT_HLFS_"CE"  ;primary key value
 S HLA("HLS",2)=PRCSEG
 ;
 ;======== CDM Segment ===========
 S PRCSEG="CDM"
 S $P(PRCSEG,HLFS,2)="V"_PRCROOT      ;primary key value
 S $P(PRCSEG,HLFS,4)="PROCUREMENT DETAIL FROM IFCAP"
 S $P(PRCSEG,HLFS,12)=PRCCN           ;contract number
 S:$G(PRCAM)="" $P(PRCSEG,HLFS,13)=PRCVEN_HLCS_HLCS_PRCDB
 S HLA("HLS",3)=PRCSEG
 ;
 ;======== PRC Segment ===========
 S PRCSEG="PRC"
 S $P(PRCSEG,HLFS,2)="V"_PRCROOT      ;primary key value
 S:$G(PRCAM)="" $P(PRCSEG,HLFS,10)="0"_HLCS_"US"
 S $P(PRCSEG,HLFS,11)=PRCAMT_HLCS_"US"
 S $P(PRCSEG,HLFS,12)=$G(PRCOD)    ;effective start date = P.O. Date
 S $P(PRCSEG,HLFS,13)=$G(PRCDD)    ;effective end date = delivery date
 S HLA("HLS",4)=PRCSEG
 ;
 ;======== ZPO Segment ===========
 ; Purchase order details - check if this PO has been amended and get
 ; just a few fields for this segment as requested by Austin Automation
 ; Center (AAC)
 I $D(^PRC(442,PRCHPO,6,0)) G AMEND
 S PRCSEG="ZPO"
 S:$G(PRCECC)'="" $P(PRCSEG,HLFS,2)=PRCECC      ;extent competed
 S:$G(PRCRNC)'="" $P(PRCSEG,HLFS,3)=PRCRNC      ;reason not competed
 S $P(PRCSEG,HLFS,4)=PRCEPAC     ;EPA designated product
 S:$G(PRCFSC)'="" $P(PRCSEG,HLFS,5)=PRCFSC      ;Federal Supply Class. (or PSC code)
 S $P(PRCSEG,HLFS,6)=PRCPP       ;place of performance question
 S $P(PRCSEG,HLFS,7)=PRCPF       ;place of performance
 S $P(PRCSEG,HLFS,8)=PRCCB       ;contract bundling
 S $P(PRCSEG,HLFS,9)="N"         ;government furnished eqmt.
 S $P(PRCSEG,HLFS,10)=PRCPER     ;DUZ^LastName^FirstName (contr. officer)
 S $P(PRCSEG,HLFS,11)=PRCMOP           ;method of processing
 S $P(PRCSEG,HLFS,12)="J"              ;type of contract
 S $P(PRCSEG,HLFS,13)=PRCAAD           ;alternative advertising
 S $P(PRCSEG,HLFS,14)=$G(PRCDS)        ;date PO was signed
 S $P(PRCSEG,HLFS,15)=PRCAT            ;award type
 S $P(PRCSEG,HLFS,16)=PRCRT            ;record type
 S $P(PRCSEG,HLFS,17)=PRCSPC           ;solicitation procedure
 S $P(PRCSEG,HLFS,18)=PRCEPC           ;evaluated preference
 S $P(PRCSEG,HLFS,19)=PRCFAC           ;funding agency code
 S $P(PRCSEG,HLFS,20)="N"              ;contract funded by foreign gov.
 S $P(PRCSEG,HLFS,21)=PRCFOC           ;funding agency office code
 S $P(PRCSEG,HLFS,22)=PRCMY            ;multiyear (for contracts)
 S $P(PRCSEG,HLFS,23)=PRCPAS           ;pre award synopsis
 S $P(PRCSEG,HLFS,24)="N"              ;synopsis waiver
 S $P(PRCSEG,HLFS,25)=PRCNOF           ;number of offers
 S $P(PRCSEG,HLFS,26)=PRCUV_HLCS_"US"  ;ultimate contract value
 S $P(PRCSEG,HLFS,27)=PRCCV_HLCS_"US"  ;current contract value
 S $P(PRCSEG,HLFS,28)=PRCDES           ;description of reqmt. (line item)
 S $P(PRCSEG,HLFS,29)=3600             ;agency identifier
 S $P(PRCSEG,HLFS,30)=PRCBZ            ;business size
 S $P(PRCSEG,HLFS,31)=PRCTSAC          ;type set aside
 S $P(PRCSEG,HLFS,32)=PRCPBC           ;perf. based service contract
 S $P(PRCSEG,HLFS,33)=3600             ;contracting agency code
 S $P(PRCSEG,HLFS,34)=PRCOFC           ;contracting office code
 S $P(PRCSEG,HLFS,35)=PRCCH            ;Clinger Cohen Act
 S $P(PRCSEG,HLFS,37)=PRCUCD           ;ultimate completion date
 S HLA("HLS",5)=PRCSEG
 G GEN
 ;
AMEND ; Get ready for a short amended message
 S PRCSEG="ZPO"
 S $P(PRCSEG,HLFS,14)=PRCDS            ;date PO was signed
 S $P(PRCSEG,HLFS,16)=PRCRT            ;record type
 S $P(PRCSEG,HLFS,20)="N"              ;contract funded by foreign govt.
 S $P(PRCSEG,HLFS,26)=PRCUV_HLCS_"US"  ;ultimate contract value
 S $P(PRCSEG,HLFS,27)=PRCCV_HLCS_"US"  ;current contract value
 S $P(PRCSEG,HLFS,29)=3600             ;agency identifier
 S $P(PRCSEG,HLFS,33)=3600             ;contracting agency code
 S $P(PRCSEG,HLFS,34)=PRCOFC           ;contracting office code
 S $P(PRCSEG,HLFS,36)=$G(PRCMN)        ;modification number (amendment #)
 S $P(PRCSEG,HLFS,38)=$G(PRCRMC)       ;reason for mod. (amend authority)
 S HLA("HLS",5)=PRCSEG
 ;
 ; Call HL7 to build/send message and get its number (PRCMID)
GEN D GENERATE^HLMA(PRCPROT,"LM",1,.PRCRSULT,"",.PRCOPTNS)
 I $P(PRCRSULT,U,1)]"" S PRCMID=$P(PRCRSULT,U,1)
 S PRCSUB=$S(PRCMID>0:"PRCHAAC1;"_PRCMID,1:"PRCHAAC1;"_"No MID")
MAIL2 ;
 S MSG(1,0)="The following Purchase Order transaction has been sent "
 S MSG(2,0)="to the Austin Automation Center (AAC) to report"
 S MSG(3,0)="required FPDS information. Please keep this information"
 S MSG(4,0)="for two weeks for tracking purposes."
 S MSG(5,0)=" "
 S MSG(6,0)="Purchase Order Number: "_$E(PRCROOT,1,3)_"-"_$E(PRCROOT,4,9)
 S MSG(7,0)=" "
 S MSG(8,0)="The HL7 Message # is: "_PRCMID
 S XMSUB="Message for PO #: "_$E(PRCROOT,1,3)_"-"_$E(PRCROOT,4,9)_" to the AAC"
 ; Get approving official for a delivery order, certified invoice, etc.
 I $D(^PRC(442,PRCHPO,10)) D
 . I $P(^PRC(442,PRCHPO,23),U,11)="D" S PRCAPPO=$P(^PRC(442,PRCHPO,10,1,0),U,2)
 . E  S PRCAPPO=$P(^PRC(442,PRCHPO,10,1,0),U,2)
 ;
 ; Get approving official for an order created by a purchasing agent
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="" D
 . I '$D(^PRC(442,PRCHPO,13)) Q
 . S PRC2237=$P(^PRC(442,PRCHPO,13,0),U,3)
 . S PRCAPPO=$P(^PRC(442,PRCHPO,13,PRC2237,0),U,2)
 ;
 ; Get authorized buyer for all POs
 S PRCPPA=$P(^PRC(442,PRCHPO,1),U,10)
 S XMDUZ=PRCDUZ
 S XMY(PRCPPA)=""
 S:$G(PRCAPPO)'="" XMY(PRCAPPO)=""
 S XMTEXT="MSG("
 D ^XMD
 ;
 D LOG^PRCHAAC2 ;log record of outgoing message to the AAC
 ; Keep track of any error found
 I $P(PRCRSULT,U,2,3)]"",+PRCMID=0 D
 . S PRCMID=$P(PRCRSULT,U,2,3)
 . S PRCERR=1
 . D REC^PRCHAAC2
 K HLA,HL,HLFS,HLCS,HLRS
 Q
