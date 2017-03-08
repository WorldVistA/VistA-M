PXVRPC4 ;BPFO/LMT - PCE RPCs for Immunization(s) ;08/15/16  17:26
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**215,216**;Aug 12, 1996;Build 11
 ;
 ; Reference to ^DIA(9999999.14,"C") supported by ICR #2602
 ; Reference to NAME in file .85 is supported by ICR #6062
 ;
IMMRPC(PXRTRN,PXIMM,PXDATE,PXLOC) ; Entry point for RPC
 ;
 ; Returns an Immunization object
 ;
 ;Input:
 ;  PXRTRN - Return value passed by reference (Required)
 ;   PXIMM - Pointer to #9999999.14 (Required)
 ;  PXDATE - Immunization status and Codes will be based off this date
 ;           (Optional; Defaults to NOW)
 ;   PXLOC - Used to determine Institution (used when filtering Lot and Defaults) (Optional)
 ;           Possible values are:
 ;             "I:X": Institution (#4) IEN #X
 ;             "V:X": Visit (#9000010) IEN #X
 ;             "L:X": Hopital Location (#44) IEN #X
 ;           If PXLOC is not passed in OR could not make determination based off
 ;           input, then default to DUZ(2), and if DUZ(2) is not defined,
 ;           default to Default Institution.
 ;
 ;Returns:
 ;   ^TMP("PXVIMMRPC",$J,0)
 ;      1:  1 - Immunization was found. The "1" node will be returned, but
 ;              the other nodes are optional.
 ;         -1 - Immunization was not found; no other nodes will be returned
 ;   ^TMP("PXVIMMRPC",$J,1)
 ;      Note: Status (in the 5th piece) is determined as follows:
 ;        - If PXDATE is today, the status is based off the Inactive Flag (#.07)
 ;        - If PXDATE is different than today, we will look when an update was
 ;          last made to the Immunization file (based off the Audits).
 ;          If there have not been any changes since PXDATE, we will get the
 ;          status based off the Inactive Flag, otherwise, we will get the
 ;          status for that date by calling GETSTAT^XTID.
 ;      1: "IMM"
 ;      2: #9999999.14 IEN
 ;      3: Name (#.01)
 ;      4: CVX Code (#.03)
 ;      5: Status (1: Active; 0: Inactive)
 ;      6: Selectable for Historic (#8803)
 ;      7: Mnemonic (#8801)
 ;      8: Acronym (#8802)
 ;      9: Max # In Series (#.05)
 ;      10: Combination Immunization (Y/N) (#.2)
 ;      11: Reading Required (#.51)
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      1: "VIS"
 ;      2: #920 IEN
 ;      3: Name (#920,#.01)
 ;      4: Edition Date (#920,#.02)
 ;      5: Edition Status (#920,#.03)
 ;      6: Language (#920, #.04)
 ;      7: 2D Bar Code (#100)
 ;      8: VIS URL (#101)
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      1: "CDC"
 ;      2: CDC Product Name (#9999999.145, #.01)
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      1: "GROUP"
 ;      2: Vaccine Group Name (#9999999.147, #.01)
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      1: "SYNONYM"
 ;      2: Synonym (#9999999.141, #.01)
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      Note: Only active codes (based off PXDATE) are returned.
 ;      1: "CS"
 ;      2: Coding System (#9999999.143, #.01)
 ;      3: Code (#9999999.1431,#.01)
 ;      4: Variable pointer. e.g., IEN;ICPT(
 ;      5: Short Description
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      Note: Only active lots for the given division are returned.
 ;            Also, the Expiration date must be >= PXDATE
 ;      1: "LOT"
 ;      2: #9999999.41 IEN
 ;      3: Lot Number (#9999999.41, #.01)
 ;      4: Manufacturer (#9999999.04, #.01)
 ;      5: Expiration Date (#9999999.41, #.09)
 ;      6: Doses Unused (#9999999.41, #.12)
 ;      7: Low Supply Alert (#9999999.41, #.15)
 ;      8: NDC Code (#9999999.41, #.18)
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      Note: Only active contraindications are returned
 ;      1: "CONTRA"
 ;      2: #920.4 variable pointer: IEN;PXV(920.4,
 ;      3: Name (#920.4, #.01)
 ;      4: Status (1:Active, 0:Inactive)
 ;      5: Code|Coding System (#920.4, #.02 and .05)
 ;      6: NIP004 (#920.4, #.04)
 ;      7: Contraindication/Precaution (#920.4, #.06)
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      1: "DEF"
 ;      2: Default Route (#920.051, #1302)
 ;      3: Default Site (#920.051, #1303)
 ;      4: Default Dose (#920.051, #1312)
 ;      5: Default Dose Units (#920.051, #1313)
 ;      6: Default Dose Units (external format) (#920.051, #1313)
 ;   ^TMP("PXVIMMRPC",$J,x)
 ;      1: "DEFC"
 ;      2: Default Comments (#920.051, #81101)
 ;
 N PXCNT,PXCODESYS,PXFLD,PXI,PXIMMARR,PXIMMSUB,PXNODE,PXSUB
 ;
 S PXSUB="PXVIMMRPC"
 S PXRTRN=$NA(^TMP(PXSUB,$J))
 K ^TMP(PXSUB,$J)
 ;
 D GETIMM(.PXIMMARR,$G(PXIMM),$G(PXDATE),$G(PXLOC))
 S PXIMMSUB="PXVIMM"
 ;
 S PXCNT=0
 ;
 I '$D(^TMP(PXIMMSUB,$J)) D  Q
 . S ^TMP(PXSUB,$J,PXCNT)="-1"
 ;
 S ^TMP(PXSUB,$J,PXCNT)=1
 S PXCNT=PXCNT+1
 S ^TMP(PXSUB,$J,PXCNT)="IMM"_U_$G(^TMP(PXIMMSUB,$J,0))
 ;
 F PXFLD="VIS","LOT","CDC","GROUP","SYNONYM","CONTRA","DEF","DEFC" D
 . I '$D(^TMP(PXIMMSUB,$J,PXFLD)) Q
 . S PXI=0 F  S PXI=$O(^TMP(PXIMMSUB,$J,PXFLD,PXI)) Q:'PXI  D
 . . S PXNODE=$G(^TMP(PXIMMSUB,$J,PXFLD,PXI,0))
 . . I PXNODE="" Q
 . . S PXCNT=PXCNT+1
 . . S ^TMP(PXSUB,$J,PXCNT)=PXFLD_U_PXNODE
 ;
 S PXFLD="CS"
 I $D(^TMP(PXIMMSUB,$J,PXFLD)) D
 . S PXCODESYS=""
 . F  S PXCODESYS=$O(^TMP(PXIMMSUB,$J,PXFLD,PXCODESYS)) Q:PXCODESYS=""  D
 . . S PXI=0
 . . F  S PXI=$O(^TMP(PXIMMSUB,$J,PXFLD,PXCODESYS,PXI)) Q:'PXI  D
 . . . S PXNODE=$G(^TMP(PXIMMSUB,$J,PXFLD,PXCODESYS,PXI,0))
 . . . I PXNODE="" Q
 . . . S PXCNT=PXCNT+1
 . . . S ^TMP(PXSUB,$J,PXCNT)=PXFLD_U_PXCODESYS_U_PXNODE
 ;
 K ^TMP(PXIMMSUB,$J)
 ;
 Q
 ;
GETIMM(PXRTRN,PXIMM,PXDATE,PXLOC) ; Entry point for API
 ;
 N PXAUDIT,PXDIV,PXI,PXINST,PXNODE,PXNODE0,PXNODETMP,PXSUB
 ;
 S PXSUB="PXVIMM"
 K ^TMP(PXSUB,$J)
 S PXRTRN=$NA(^TMP(PXSUB,$J))
 ;
 I '$G(PXIMM) Q
 I '$D(^AUTTIMM(PXIMM,0)) Q
 I '$G(PXDATE) S PXDATE=$$NOW^XLFDT()
 S PXINST=$$INST^PXVUTIL($G(PXLOC))
 ;
 S PXAUDIT=0
 I $$GET1^DID(9999999.14,.07,"","AUDIT")="YES, ALWAYS" S PXAUDIT=1
 ;
 S PXNODE0=^AUTTIMM(PXIMM,0)
 S PXNODETMP=PXIMM_U_$P(PXNODE0,U,1)_U_$P(PXNODE0,U,3)
 S PXNODETMP=PXNODETMP_U_$$GETSTAT(PXIMM,PXDATE,$$GETCSTAT(PXDATE,PXAUDIT),PXAUDIT)
 S PXNODE=$P($G(^AUTTIMM(PXIMM,6)),U,1)
 S PXNODETMP=PXNODETMP_U_PXNODE
 S PXNODE=$G(^AUTTIMM(PXIMM,88))
 S PXNODETMP=PXNODETMP_U_$P(PXNODE,U,1)
 S PXNODETMP=PXNODETMP_U_$P(PXNODE,U,2)
 S PXNODETMP=PXNODETMP_U_$P(PXNODE0,U,5)_U_$P(PXNODE0,U,20)
 S PXNODE=$P($G(^AUTTIMM(PXIMM,.5)),U,1)
 S PXNODETMP=PXNODETMP_U_PXNODE
 S ^TMP(PXSUB,$J,0)=PXNODETMP
 ;
 I $D(^AUTTIMM(PXIMM,3)) D GETCS(PXSUB,PXIMM,PXDATE)
 I $D(^AUTTIMM(PXIMM,4)) D GETVIS(PXSUB,PXIMM)
 F PXI=5,7,10 I $D(^AUTTIMM(PXIMM,PXI)) D GETSUBS(PXSUB,PXIMM,PXI)
 D GETLOT(PXSUB,PXIMM,PXDATE,PXINST)
 D GETCONT(PXSUB,PXIMM) ; Get Contraindications
 D GETDEF(PXSUB,PXIMM,PXINST) ; Get Defaults
 ;
 Q
 ;
GETCS(PXSUB,PXIMM,PXDATE) ;
 ;
 N PXCNT,PXCODE,PXCODESYS,PXCODESYSLEX,PXLEX,PXLEXADATE,PXLEXARY,PXLEXIDATE,PXLEXNODE,PXLEXSUB,PXX,PXY
 ;
 S PXDATE=$P(PXDATE,".",1)
 S PXCNT=0
 ;
 S PXX=0
 F  S PXX=$O(^AUTTIMM(PXIMM,3,PXX)) Q:'PXX  D
 . S PXCODESYS=$G(^AUTTIMM(PXIMM,3,PXX,0))
 . I PXCODESYS="" Q
 . S PXCODESYSLEX=PXCODESYS
 . I PXCODESYSLEX?1(1"CPT-ADD",1"CPT-ADM") S PXCODESYSLEX=$P(PXCODESYSLEX,"-",1)
 . S PXY=0 F  S PXY=$O(^AUTTIMM(PXIMM,3,PXX,1,PXY)) Q:'PXY  D
 . . S PXCODE=$G(^AUTTIMM(PXIMM,3,PXX,1,PXY,0))
 . . I PXCODE="" Q
 . . ;
 . . K PXLEXARY
 . . S PXLEX=$$PERIOD^LEXU(PXCODE,PXCODESYSLEX,.PXLEXARY)
 . . ;
 . . I $P(PXLEX,U,1)=-1 D  Q
 . . . I PXCODESYSLEX?1(1"CPT",1"10D") Q
 . . . S PXCNT=PXCNT+1
 . . . S ^TMP(PXSUB,$J,"CS",PXCODESYS,PXCNT,0)=PXCODE
 . . ;
 . . S PXLEXADATE=$O(PXLEXARY((PXDATE+.00001)),-1)
 . . I PXLEXADATE="" Q
 . . S PXLEXNODE=$G(PXLEXARY(PXLEXADATE))
 . . S PXLEXIDATE=$P(PXLEXNODE,U,1)
 . . I PXLEXIDATE,PXDATE>PXLEXIDATE Q
 . . S PXCNT=PXCNT+1
 . . S ^TMP(PXSUB,$J,"CS",PXCODESYS,PXCNT,0)=PXCODE_U_$P(PXLEXNODE,U,3)_U_$P(PXLEXNODE,U,4)
 ;
 Q
 ;
GETVIS(PXSUB,PXIMM) ;
 ;
 N PXBAR,PXCNT,PXLANG,PXNODE,PXURL,PXVIS,PXX
 ;
 S PXCNT=0
 S PXX=0
 F  S PXX=$O(^AUTTIMM(PXIMM,4,PXX)) Q:'PXX  D
 . S PXVIS=+$G(^AUTTIMM(PXIMM,4,PXX,0))
 . I PXVIS'>0 Q
 . I '$D(^AUTTIVIS(PXVIS,0)) Q
 . S PXNODE=$G(^AUTTIVIS(PXVIS,0))
 . I PXNODE="" Q
 . S PXLANG=$P(PXNODE,U,4)
 . I PXLANG'="" S PXLANG=$$GET1^DIQ(.85,PXLANG_",","NAME")  ;ICR 6062
 . S PXBAR=$P($G(^AUTTIVIS(PXVIS,100)),U,1)
 . S PXURL=$G(^AUTTIVIS(PXVIS,101))
 . S PXCNT=PXCNT+1
 . S ^TMP(PXSUB,$J,"VIS",PXCNT,0)=PXVIS_U_$P(PXNODE,U,1,3)_U_PXLANG_U_PXBAR_U_PXURL
 Q
 ;
GETSUBS(PXSUB,PXIMM,PXMULT) ;
 ;
 N PXCNT,PXFLD,PXNODE,PXX
 ;
 S PXFLD=$S(PXMULT=5:"CDC",PXMULT=7:"GROUP",PXMULT=10:"SYNONYM",1:"")
 I PXFLD="" Q
 S PXCNT=0
 S PXX=0 F  S PXX=$O(^AUTTIMM(PXIMM,PXMULT,PXX)) Q:'PXX  D
 . S PXNODE=$G(^AUTTIMM(PXIMM,PXMULT,PXX,0)) Q:PXNODE=""
 . S PXCNT=PXCNT+1
 . S ^TMP(PXSUB,$J,PXFLD,PXCNT,0)=PXNODE
 Q
 ;
GETLOT(PXSUB,PXIMM,PXDATE,PXINST) ;
 ;
 N PXCNT,PXEXPDATE,PXLOT,PXMAN,PXNDC,PXNODE,PXSTAT,PXTEMP
 ;
 S PXCNT=0
 S PXLOT=0
 F  S PXLOT=$O(^AUTTIML("C",PXIMM,PXLOT)) Q:'PXLOT  D
 . S PXNODE=$G(^AUTTIML(PXLOT,0))
 . I PXNODE="" Q
 . S PXEXPDATE=$P(PXNODE,U,9)
 . I $P(PXDATE,".",1)>$P(PXEXPDATE,".",1) Q
 . S PXSTAT=$P(PXNODE,U,3)
 . I PXSTAT>0 Q
 . ; check if selectable for this facility
 . I $G(PXINST),'$$IMMSEL^PXVXR(PXLOT,PXINST) Q
 . S PXMAN=$P(PXNODE,U,2)
 . I PXMAN S PXMAN=$P($G(^AUTTIMAN(PXMAN,0)),U,1)
 . S PXNDC=$P(PXNODE,U,18)
 . S PXCNT=PXCNT+1
 . S PXTEMP=PXLOT_U_$P(PXNODE,U,1)_U_PXMAN_U_PXEXPDATE_U_$P(PXNODE,U,12)_U_$P(PXNODE,U,15)_U_PXNDC
 . S ^TMP(PXSUB,$J,"LOT",PXCNT,0)=PXTEMP
 Q
 ;
GETCONT(PXSUB,PXIMM) ; Get Contraindications
 ;
 N PXCNT,PXFLDS,PXIEN,PXSKIP,PXSTAT
 ;
 S PXCNT=0
 S PXIEN=0
 F  S PXIEN=$O(^PXV(920.4,PXIEN)) Q:'PXIEN  D
 . ;
 . S PXSKIP=0
 . I $O(^PXV(920.4,PXIEN,3,0)) D
 . . I '$O(^PXV(920.4,PXIEN,3,"B",PXIMM,0)) S PXSKIP=1
 . I PXSKIP Q
 . ;
 . S PXFLDS=$$GETFLDS^PXVRPC5(920.4,PXIEN)
 . S PXSTAT=$P(PXFLDS,U,3)
 . I 'PXSTAT Q
 . S PXCNT=PXCNT+1
 . S ^TMP(PXSUB,$J,"CONTRA",PXCNT,0)=PXFLDS
 Q
 ;
GETDEF(PXSUB,PXIMM,PXINST) ; Get defaults
 ;
 N PXDFLTS,PXNODE,PXTMP
 ;
 I '$G(PXINST) Q
 ;
 D IMMDEF^PXAPIIM(.PXDFLTS,PXIMM,PXINST)
 I '$D(PXDFLTS) Q
 ;
 S PXNODE=$G(PXDFLTS(13))
 S PXTMP=$P(PXNODE,U,2,3)_U_$P(PXNODE,U,12,13)
 I $P(PXTMP,U,4) D
 . S $P(PXTMP,U,5)=$$EXTERNAL^DILFD(9000010.11,1313,"",$P(PXTMP,U,4))
 I PXTMP'="^^^" S ^TMP(PXSUB,$J,"DEF",1,0)=PXTMP
 ;
 S PXNODE=$G(PXDFLTS(811))
 I PXNODE'="" S ^TMP(PXSUB,$J,"DEFC",1,0)=PXNODE
 ;
 Q
 ;
IMMSHORT(PXRSLT,PXFILTER,PXDATE) ;
 ;
 ; Return short list of immunizations
 ;
 ;Input:
 ;    PXRSLT - Return value passed by reference (Required)
 ;  PXFILTER - Filter (Optional; Defaults to "B")
 ;             Possible values are:
 ;               "A": Only return active entries
 ;               "H": Only return entries marked as Selectable for Historic
 ;               "B": Return both active entries and those marked as Selectable for Historic
 ;    PXDATE - Date (optional; defaults to TODAY)
 ;             Used for determining immunization status (both for filtering and for return value)
 ;
 ;Returns:
 ;   PXRTRN(x)
 ;      Note: Status (in the 5th piece) is determined as follows:
 ;        - If PXDATE is today, the status is based off the Inactive Flag (#.07)
 ;        - If PXDATE is different than today, we will look when an update was
 ;          last made to the Immunization file (based off the Audits).
 ;          If there have not been any changes since PXDATE, we will get the
 ;          status based off the Inactive Flag, otherwise, we will get the
 ;          status for that date by calling GETSTAT^XTID.
 ;      1: "IMM"
 ;      2: #9999999.14 IEN
 ;      3: Name (#.01)
 ;      4: CVX Code (#.03)
 ;      5: Status (1: Active; 0: Inactive)
 ;      6: Selectable for Historic (#8803)
 ;      7: Mnemonic (#8801)
 ;      8: Acronym (#8802)
 ;   PXRTRN(x)
 ;      1: "CDC"
 ;      2: CDC Product Name (#9999999.145, #.01)
 ;
 N PXAUDIT,PXCNT,PXGETCSTAT,PXIEN,PXNODE,PXSELHIST,PXSTAT,PXX
 ;
 I $G(PXFILTER)'?1(1"A",1"H",1"B") S PXFILTER="B"
 I '$G(PXDATE) S PXDATE=DT
 S PXAUDIT=0
 I $$GET1^DID(9999999.14,.07,"","AUDIT")="YES, ALWAYS" S PXAUDIT=1
 S PXGETCSTAT=$$GETCSTAT(PXDATE,PXAUDIT)
 ;
 S PXCNT=0
 S PXIEN=0
 F  S PXIEN=$O(^AUTTIMM(PXIEN)) Q:PXIEN'>0  D
 . S PXSELHIST=$P($G(^AUTTIMM(PXIEN,6)),U)
 . S PXSTAT=$$GETSTAT(PXIEN,PXDATE,PXGETCSTAT,PXAUDIT)
 . I PXFILTER="A",'PXSTAT Q
 . I PXFILTER="H",PXSELHIST'="Y" Q
 . I PXFILTER="B",'PXSTAT,PXSELHIST'="Y" Q
 . ;
 . S PXCNT=PXCNT+1
 . S PXNODE=$G(^AUTTIMM(PXIEN,0))
 . S PXRSLT(PXCNT)="IMM"_U_PXIEN_U_$P(PXNODE,U,1)_U_$P(PXNODE,U,3)_U_PXSTAT_U_PXSELHIST
 . S PXNODE=$G(^AUTTIMM(PXIEN,88))
 . I PXNODE'="",PXNODE'=U S PXRSLT(PXCNT)=PXRSLT(PXCNT)_U_PXNODE
 . S PXX=0
 . F  S PXX=$O(^AUTTIMM(PXIEN,5,PXX)) Q:PXX'>0  D
 . . S PXNODE=$G(^AUTTIMM(PXIEN,5,PXX,0))
 . . I PXNODE="" Q
 . . S PXCNT=PXCNT+1
 . . S PXRSLT(PXCNT)="CDC"_U_PXNODE
 Q
 ;
GETSTAT(PXIMM,PXDATE,PXCURR,PXAUDIT) ;
 ;
 N PXLASTEDIT
 ;
 I PXCURR Q '$P($G(^AUTTIMM(PXIMM,0)),U,7)
 ;
 I PXAUDIT D
 . S PXLASTEDIT=$P($$LAST^DIAUTL(9999999.14,PXIMM,".07"),U,1)
 . I PXDATE>PXLASTEDIT S PXCURR=1
 I PXCURR Q '$P($G(^AUTTIMM(PXIMM,0)),U,7)
 ;
 Q $P($$GETSTAT^XTID(9999999.14,"",PXIMM_",",$G(PXDATE)),U,1)
 ;
GETCSTAT(PXDATE,PXAUDIT) ;
 ;
 ; Should we get current status of IMM entries or should we call GETSTAT^XTID
 ; to get status as of a specific date?
 ; Since GETSTAT^XTID is slow, we try to avoid it when possible.
 ;
 ; Returns: 0 - Call GETSTAT^XTID
 ;          1 - Get current status
 ;
 N PXLASTEDITDT,PXRSLT
 ;
 S PXRSLT=0
 ;
 I '$G(PXDATE) D  Q PXRSLT
 . S PXRSLT=1
 ;
 I $P(PXDATE,".",1)=DT D  Q PXRSLT
 . S PXRSLT=1
 ;
 ; If Inactive Flag is being audited (which should be the case)
 ; then get current status, if file has not been updated since PXDATE
 I PXAUDIT D
 . S PXLASTEDITDT=$O(^DIA(9999999.14,"C",""),-1)   ;ICR #2602
 . I PXDATE>PXLASTEDITDT S PXRSLT=1
 ;
 Q PXRSLT
 ;
IMMADMCD(PXRSLT,PXDATE) ;
 ;
 ; Returns Immunization Admin CPT codes
 ;
 ;Input:
 ;  PXRTRN - Return value passed by reference (Required)
 ;  PXDATE - Code status will be based off this date
 ;           (Optional; Defaults to TODAY)
 ;
 ;Returns:
 ;   PXRSLT(0) = Count of elements returned (0 if nothing found)
 ;   PXRSLT(n) =
 ;      Note: Only active codes (based off PXDATE) are returned.
 ;      1: "CPT-ADM" or "CPT-ADD"
 ;      2: Code
 ;      3: Variable pointer. e.g., IEN;ICPT(
 ;      4: Short Description
 ;
 N PXCNT,PXFLD,PXI,PXIMM,PXNODE,PXSUB
 ;
 S PXSUB="PXVIMMCODE"
 K ^TMP(PXSUB,$J)
 ;
 S PXCNT=0
 I '$G(PXDATE) S PXDATE=DT
 S PXIMM=$$IMMNODEF^PXAPIIM()
 I 'PXIMM S PXRSLT(PXCNT)=0 Q
 ;
 D GETCS(PXSUB,PXIMM,PXDATE)
 F PXFLD="CPT-ADM","CPT-ADD" D
 . I '$D(^TMP(PXSUB,$J,"CS",PXFLD)) Q
 . S PXI=0 F  S PXI=$O(^TMP(PXSUB,$J,"CS",PXFLD,PXI)) Q:'PXI  D
 . . S PXNODE=$G(^TMP(PXSUB,$J,"CS",PXFLD,PXI,0))
 . . I PXNODE="" Q
 . . S PXCNT=PXCNT+1
 . . S PXRSLT(PXCNT)=PXFLD_U_PXNODE
 ;
 K ^TMP(PXSUB,$J)
 S PXRSLT(0)=PXCNT
 ;
 Q
