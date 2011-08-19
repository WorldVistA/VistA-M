IBCNRSM ;DAOU/BEE - Shared Plan Matches Report ;14-OCT-2004
 ;;2.0;INTEGRATED BILLING;**322**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; e-Pharmacy Shared Plan Matches Report
 ;
 ; Input parameter: N/A
 ;
 ; Predefined Variables:  U => "^"
 ;                       DT => Current System Date (VA format: yyymmdd)
 ;
 ; Other relevant variables:
 ;   IBCNRRTN = "IBCNRSM" (current routine name, used for ^XTMP and ^TMP
 ;                         storage subscript)
 ; Storage Global:
 ;   ^XTMP("IBCNRSM",0) = Piece 1^Piece 2^Piece 3^Piece 4^Piece 5^Piece 6
 ;      where:
 ;      Piece 1 => Purge Date - 1 year in future
 ;      Piece 2 => Create Date - Today
 ;      Piece 3 => Description
 ;      Piece 4 => Last Date Compiled
 ;      Piece 5 => $H of Paid Date Compile
 ;      Piece 6 => $H last run completion time
 ;
 ;   ^XTMP("IBCNRSM",1,IEN) = LDT
 ;      where:
 ;          IEN => Internal GROUP INSURANCE index entry
 ;          LDT => Last Date Paid, VA Fileman Format
 ;
 ; Entry Point - TASKMAN => Run report in background using TASKMAN
 ;
 Q
 ;
 ; TASKMAN ENTRY POINT
 ;
TASKMAN N IBCNRRTN,P,D0,D1,D2,DG,DIC,DICR,DISYS,DIW,Y
 ;
 ;Process Report
 ;
 ;Initialize variables
 S IBCNRRTN="IBCNRSM"
 S P="|"
 ;
 ;Check to see if report is in use
 L +^XTMP(IBCNRRTN):5 I '$T G EXIT
 ;
 ;Reset Temporary Scratch Global
 K ^TMP(IBCNRRTN,$J)
 ;
 ;Check for required variables
 I $G(U)=""!($G(DT)="") G EXIT
 ;
 ;Pull Station (Institution) address
 D STAT(IBCNRRTN)
 ;
 ;Perform Compile
 ;
 ;Recompile the Paid Date Index
 D PDT(IBCNRRTN,DT)
 ;
 ;Process the entries
 D PROC(IBCNRRTN)
 ;
 ;Send the message
 D EMAIL(IBCNRRTN)
 ;
 ;Log Run Completion Time
 S $P(^XTMP(IBCNRRTN,0),U,6)=$H
 ;
 ;Standard EXIT point
EXIT K ^TMP(IBCNRRTN,$J)
 L -^XTMP(IBCNRRTN)
 K IBCNRRTN,P,D0,D1,D2,DG,DIC,DICR,DISYS,DIW,Y
 Q
 ;
 ; PULL STATION AND INSTITUTION ADDRESS
 ;
STAT(IBCNRRTN) N INST,N,CITY,SINFO,SITE,STATE,ZIP
 S (CITY,STATE,ZIP)=""
 ;
 ;Pull Site Info
 S SINFO=$$SITE^VASITE
 S SITE=$P(SINFO,U,3)
 S INST=$P(SINFO,U)
 ;
 I INST D
 .S N(0)=$G(^DIC(4,INST,0))
 .S N(1)=$G(^DIC(4,INST,1))
 .S CITY=$P(N(1),U,3)
 .S STATE=$P(N(0),U,2)
 .I STATE S STATE=$P($G(^DIC(5,STATE,0)),U,2)
 .S ZIP=$P(N(1),U,4)
 S ^TMP(IBCNRRTN,$J,1)="Station: "_SITE_P_CITY_P_STATE_P_ZIP
 ;
 K IBCNRRTN,INST,N,CITY,SINFO,SITE,STATE,ZIP
 Q
 ;
 ; PROCESS EACH GROUP INSURANCE ENTRY
 ;
PROC(IBCNRRTN) N COUNT,IGRP,IPAYER,IINS,GRPDATA,INSDATA,PLNDATA,PAYDATA,PDTDATA,PLANID
 ;
 ;Initialize Counter
 S COUNT=1
 ;
 ;Loop through GROUP INSURANCE PLAN and process any item with a PLANID
 S IGRP=0 F  S IGRP=$O(^IBA(355.3,IGRP)) Q:'IGRP  D
 .;
 .;Get PLANID and process each entry
 .S PLANID=$P($G(^IBA(355.3,IGRP,6)),U) I 'PLANID Q
 .;
 .;Pull Group Information
 .S GRPDATA=$$GRP(IGRP)
 .;
 .;Get Insurance Lookup from GROUP INSURANCE
 .S IINS=+$P($G(^IBA(355.3,IGRP,0)),U)
 .;
 .;Pull Insurance Information from INSURANCE COMPANY
 .S INSDATA=$$INS(IINS)
 .;
 .;Get Plan info from PLAN
 .S PLNDATA=$$PLAN(PLANID) I PLNDATA="" Q
 .;
 .;Get Payer Lookup from PLAN
 .S IPAYER=+$P($G(^IBCNR(366.03,PLANID,0)),U,3)
 .;
 .;If no (or invalid) Payer Lookup in PLAN, Pull from INSURANCE COMPANY
 .I IPAYER=0!('$D(^IBE(365.12,IPAYER,0))) S IPAYER=+$P($G(^DIC(36,IINS,3)),U,10)
 .;
 .;Pull Payer Information
 .S PAYDATA=P_P I IPAYER S PAYDATA=$$PAYER(IPAYER)
 .;
 .;Last Paid Date
 .S PDTDATA=$$PAID(IBCNRRTN,IGRP)
 .;
 .;Update Counter and Save Entry
 .S COUNT=$G(COUNT)+1
 .S ^TMP(IBCNRRTN,$J,COUNT)=INSDATA_P_PAYDATA_P_GRPDATA_P_PLNDATA_P_PDTDATA
 ;
 K IBCNRRTN,COUNT,IGRP,IPAYER,IINS,GRPDATA,INSDATA,PLNDATA,PAYDATA,PDTDATA,PLANID
 Q
 ;
 ; PULL GROUP INFORMATION
 ;
 ; Function Returns Piece 1 -> Group Name
 ;                        2 -> Group Number
 ;                    
GRP(IGRP) N GRPDATA,NAME,NUMB,N
 ;
 S N=$G(^IBA(355.3,IGRP,0))
 ;
 ;Group Name
 S NAME=$P(N,U,3)
 ;
 ;Group Number
 S NUMB=$P(N,U,4)
 ;
 S GRPDATA=NAME_P_NUMB
 K IGRP,NAME,NUMB,N
 Q GRPDATA
 ;
 ; GET INSURANCE INFORMATION
 ;
 ; Return Variable:  Piece 1 -> Company Name
 ;                         2 -> Company Address 1
 ;                         3 -> Company Address 2
 ;                         4 -> Company City
 ;                         5 -> Company State
 ;                         6 -> Company Zip Code
 ;                           
INS(IINS) N ADDR1,ADDR2,CITY,NAME,N,STATE,ZIP
 ;
 ;Reset Return Variable
 S INSDATA=P_P_P_P_P I IINS="" G XINS
 ;
 S NAME=$P($G(^DIC(36,IINS,0)),U)
 S N=$G(^DIC(36,IINS,.11))
 S ADDR1=$P(N,U,1)                              ;Address Line 1
 S ADDR2=$P(N,U,2)                              ;Address Line 2
 S CITY=$P(N,U,4)                               ;City
 S STATE=$P(N,U,5)                              ;State
 I STATE]"" S STATE=$P($G(^DIC(5,STATE,0)),U,2)
 S ZIP=$P(N,U,6)                                ;Zip Code
 ;
XINS I IINS]"" S INSDATA=NAME_P_ADDR1_P_ADDR2_P_CITY_P_STATE_P_ZIP
 K IINS,ADDR1,ADDR2,CITY,NAME,N,STATE,ZIP
 Q INSDATA
 ;
 ; GET PAYER INFORMATION
 ;
 ; Return Variable: Piece 1 -> VA National Payer ID
 ;                        2 -> Professional ID
 ;                        3 -> Institutional ID
 ;
PAYER(IPAYER) N N,VAID,PROF,INST,PAYDATA
 ;
 S N=$G(^IBE(365.12,IPAYER,0))
 S VAID=$P(N,U,2)                ;VA National Payer ID
 S PROF=$P(N,U,5)                ;Professional ID
 S INST=$P(N,U,6)                ;Institutional ID
 ;
 S PAYDATA=INST_P_PROF_P_VAID
 K IPAYER,N,VAID,PROF,INST
 Q PAYDATA
 ;
 ; GET PLAN INFORMATION
 ;
 ; Return Variable: Piece 1 -> VA National Plan ID
 ;
PLAN(PLANID) N PLNDATA
 ;
 ;Get Plan ID
 S PLNDATA=$P($G(^IBCNR(366.03,PLANID,0)),U)
 ;
 K PLANID
 Q PLNDATA
 ;
 ; GET LAST DATE PAID
 ;
PAID(IBCNRRTN,IGRP) N PDTDATA
 ;
 ;Pull Last Date Paid from Storage Global
 S PDTDATA=$G(^XTMP(IBCNRRTN,1,IGRP))
 ;
 ;Convert to External Format
 I PDTDATA]"" S PDTDATA=PDTDATA+17000000
 ;
 K IBCNRRTN,IGRP
 Q PDTDATA
 ;
 ; COMPILE THE PAID DATE SCRATCH GLOBAL
 ;
PDT(IBCNRRTN,DATE) N CDT,RDT,LDT,LASTDT,XBPS,CID,IEN,DESC
 ;
 ;Pull the current information from ^XTMP
 S CDT=$P($G(^XTMP(IBCNRRTN,0)),U,4)  ;Last Date Compiled
 ;
 ;Capture the most current response entry
 S LASTDT=$P($O(^BPSR("AE",""),-1),".")
 ;
 ;Loop through Response Received Index and get latest paid date
 S RDT="" F  S RDT=$O(^BPSR("AE",RDT),-1),LDT=$P(RDT,".") Q:RDT=""!(LDT<CDT)  D
 .S XBPS="" F  S XBPS=$O(^BPSR("AE",RDT,XBPS)) Q:XBPS=""  D
 ..;
 ..;Screen out any non-accepted claims
 ..I $P($G(^BPSR(XBPS,500)),U)'="A" Q
 ..;
 ..;Pull Claim Internal ID
 ..S CID=$P($G(^BPSR(XBPS,0)),U) I CID="" Q
 ..;
 ..;Pull VA Plan IEN (Lookup to Group Insurance)
 ..S IEN=$P($G(^BPSC(CID,1)),U,4) I IEN="" Q
 ..;
 ..;If more recent Response Date update storage entry
 ..I (LDT>$G(^XTMP(IBCNRRTN,1,IEN))) S ^XTMP(IBCNRRTN,1,IEN)=LDT
 ;
 ;Update ^XTMP(IBCNRRTN,0) top level entry
 S DESC="Shared Plan Matches Report Storage - Do Not Delete"
 S ^XTMP(IBCNRRTN,0)=(DATE+10000)_U_DATE_U_DESC_U_LASTDT_U_$H
 ;
 K IBCNRRTN,DATE,CDT,RDT,LDT,XBPS,CID,IEN,DESC,LASTDT
 Q
 ;
 ; EMAIL THE MESSAGE
 ;
EMAIL(IBCNRRTN) N XMY,XMTEXT,XMSUB,XMDUN,XMDUZ,XMZ
 ;
 S XMTEXT="^TMP("""_IBCNRRTN_""","_$J_","
 S XMY("JANUS@MED.VA.GOV")=""
 S XMSUB=$TR($P($G(^TMP(IBCNRRTN,$J,1)),P),":")_" Matches"
 D ^XMD
 ;
 K IBCNRRTN,XMY,XMTEXT,XMSUB,XMDUN,XMDUZ,XMZ
 Q
