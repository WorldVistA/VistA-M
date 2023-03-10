IBTASFAC ; AITC/MRD - TAS RPC - Facilities RPC ;Feb 20, 2019@13:53:52
 ;;2.0;INTEGRATED BILLING;**638**;21-MAR-94;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; The Facilities RPC is used by the TAS application to maintain
 ; a mapping of VISNs to Stations, including the state of each
 ; Station and which Stations are also Divisions.  This information
 ; comes from file# 4, Institution, most of which is pushed out to
 ; each site from FORUM.  Each site may add local entries.  Local
 ; entries will not be returned by this RPC.  The TAS application
 ; also maintains a mapping of CPACs to VISNs.  That information
 ; cannot be found on VistA and comes from another source, such as
 ; a published PDF listing all CPACs and VISNs.
 ;
FACILITY(RESULT,ARG) ;
 ;
 N IBLIST
 ;
 S RESULT=$NA(^TMP("JSON",$J))
 K @RESULT
 ;
 D VISNS(.IBLIST)
 D DIVISIONS(.IBLIST)
 D STATIONS(.IBLIST)
 D RESULTS(.IBLIST,RESULT)
 ;
 Q
 ;
 ; VISNS builds an array listing all VISNs.  It will skip
 ; VISN 99 and any site-defined VISNs, identified by having
 ; anything after the two-digit number in the VISN name.
 ; Format of array:
 ;   IBLIST(VISN IEN) = VISN Name
 ;
VISNS(IBLIST) ;
 ;
 N IBVIEN,IBVISN,IBVISNNAME
 ;
 S IBVISN="VISN"
 F  S IBVISN=$O(^DIC(4,"B",IBVISN)) Q:IBVISN'?1"VISN".E  D
 . I IBVISN'?1"VISN "1.2N Q
 . I $P(IBVISN," ",2)'<99 Q
 . S IBVIEN=$O(^DIC(4,"B",IBVISN,0))
 . ;
 . ; Add a leading zero if the VISN number is a single digit.
 . ;
 . S IBVISNNAME=IBVISN
 . I $L($P(IBVISN," ",2))=1 S IBVISNNAME="VISN 0"_$P(IBVISN," ",2)
 . S IBLIST(IBVIEN)=IBVISNNAME
 . Q
 Q
 ;
 ; DIVISIONS gathers the list of Divisions, which must be done
 ; before building the list of Stations.  Only active, National
 ; entries will be included.
 ; Format of array:
 ;   IBLIST(VISN IEN, Division IEN) = Division #
 ;
DIVISIONS(IBLIST) ;
 ;
 N IBDIVISION,IBIDNO,IBINST,IBPARENTDIV,IBPARENTVISN,IBVISN
 ;
 S IBVISN=$O(^DIC(4.05,"B","VISN",""))
 S IBDIVISION=$O(^DIC(4.05,"B","PARENT FACILITY",""))
 ;
 S IBINST=0
 F  S IBINST=$O(^DIC(4,IBINST)) Q:'IBINST  D
 . I $$GET1^DIQ(4,IBINST,11,"I")'="N" Q  ; Skip if not a National entry (i.e. skip local entries).
 . I $$GET1^DIQ(4,IBINST,101,"I")=1 Q  ; Skip if the Inactive Facility Flag is '1'.
 . I $E($$GET1^DIQ(4,IBINST,.01),1,2)="ZZ" Q  ; Skip any entries beginning with "ZZ".
 . ;
 . ; Determine the parent VISN.
 . ;
 . S IBPARENTVISN=$O(^DIC(4,IBINST,7,"B",IBVISN,""))
 . I IBPARENTVISN'="" S IBPARENTVISN=$$GET1^DIQ(4.014,IBPARENTVISN_","_IBINST,1,"I")
 . I IBPARENTVISN="" Q
 . ;
 . ; Quit if the parent VISN is not on the list of VISNs.
 . ; Quit if this entry is the parent VISN.
 . ;
 . I '$D(IBLIST(IBPARENTVISN)) Q
 . I IBPARENTVISN=IBINST Q
 . ;
 . ; Determine the parent Division.
 . ;
 . S IBPARENTDIV=$O(^DIC(4,IBINST,7,"B",IBDIVISION,""))
 . I IBPARENTDIV'="" S IBPARENTDIV=$$GET1^DIQ(4.014,IBPARENTDIV_","_IBINST,1,"I")
 . I IBPARENTDIV="" Q
 . ;
 . ; Quit if the parent VISN and parent Division are the same.
 . ; Quit if the parent Division has no Station Number.
 . ; Quit if the Station Number is other than three digits.
 . ;
 . I IBPARENTVISN=IBPARENTDIV Q
 . ;
 . S IBIDNO=$$GET1^DIQ(4,IBPARENTDIV,99)
 . I IBIDNO="" Q
 . I IBIDNO'?3N Q
 . ;
 . ; Divisions are identified two ways:  a) it lists itself as a parent;
 . ; b) the Station Number (field# 99) is the same as the IEN.
 . ; If either is true, add this as a Division.
 . ;
 . I IBPARENTDIV=IBINST S IBLIST(IBPARENTVISN,IBPARENTDIV)=IBIDNO Q
 . I $$GET1^DIQ(4,IBINST,99)=IBINST S IBLIST(IBPARENTVISN,IBPARENTDIV)=IBIDNO
 . ;
 . Q
 Q
 ;
 ; STATIONS builds a list of stations associated with each Division
 ; and VISN.  Only active, National entries will be included.
 ; Format of array:
 ;   IBLIST(VISN IEN, Division IEN, Station IEN) = ""
 ;
STATIONS(IBLIST) ;
 ;
 N IBDIVISION,IBINST,IBPARENTDIV,IBPARENTVISN,IBVISN
 ;
 S IBVISN=$O(^DIC(4.05,"B","VISN",""))
 S IBDIVISION=$O(^DIC(4.05,"B","PARENT FACILITY",""))
 ;
 S IBINST=0
 F  S IBINST=$O(^DIC(4,IBINST)) Q:'IBINST  D
 . I $$GET1^DIQ(4,IBINST,11,"I")'="N" Q  ; Skip if not a National entry (i.e. skip local entries).
 . I $$GET1^DIQ(4,IBINST,101,"I")=1 Q  ; Skip if the Inactive Facility Flag is '1'.
 . I $E($$GET1^DIQ(4,IBINST,.01),1,2)="ZZ" Q  ; Skip any entries beginning with "ZZ".
 . ;
 . ; Determine the parent VISN.
 . ;
 . S IBPARENTVISN=$O(^DIC(4,IBINST,7,"B",IBVISN,""))
 . I IBPARENTVISN'="" S IBPARENTVISN=$$GET1^DIQ(4.014,IBPARENTVISN_","_IBINST,1,"I")
 . I IBPARENTVISN="" Q
 . ;
 . ; Quit if the parent VISN is not on the list of VISNs.
 . ;
 . I '$D(IBLIST(IBPARENTVISN)) Q
 . ;
 . ; Determine the parent Division.
 . ;
 . S IBPARENTDIV=$O(^DIC(4,IBINST,7,"B",IBDIVISION,""))
 . I IBPARENTDIV'="" S IBPARENTDIV=$$GET1^DIQ(4.014,IBPARENTDIV_","_IBINST,1,"I")
 . I IBPARENTDIV="" Q
 . ;
 . ; Do not add a Division to the list of Stations for itself.
 . ; Divisions are identified two ways:  a) it lists itself as a parent;
 . ; b) the Station Number (field# 99) is the same as the IEN.  Either
 . ; may be true
 . ;
 . I IBPARENTDIV=IBINST Q
 . I $$GET1^DIQ(4,IBINST,99)=IBINST Q
 . ;
 . ; If the parent VISN is on the list of VISNs, and the parent Division
 . ; is on the list of Divisions, then add this station to the list.
 . ;
 . I $D(IBLIST(IBPARENTVISN,IBPARENTDIV)) S IBLIST(IBPARENTVISN,IBPARENTDIV,IBINST)=""
 . ;
 . Q
 Q
 ;
 ; RESULTS builds the temp global to be passed into ENCODE^XLFJSON,
 ; which will create the JSON.
 ; Format of array:
 ;   IBLIST(VISN IEN) = VISN Name
 ;   IBLIST(VISN IEN, Division IEN) = Division #
 ;   IBLIST(VISN IEN, Division IEN, Station IEN) = ""
 ;
RESULTS(IBLIST,RESULT) ; Move into result in vaid json format
 ;
 N IBDIV,IBDIVCNT,IBIDNO,IBNAME,IBSTACNT,IBSTATE
 N IBSTATION,IBTEMP,IBVISN,IBVISNCNT,X
 ;
 S IBTEMP=$NA(^TMP("IBTAS",$J))
 K @IBTEMP
 ;
 S IBVISNCNT=0
 ;
 S IBVISN=0
 F  S IBVISN=$O(IBLIST(IBVISN)) Q:'IBVISN  I $D(IBLIST(IBVISN))=11 D
 . S IBVISNCNT=IBVISNCNT+1
 . S @IBTEMP@("VISNs",IBVISNCNT,"Name")=IBLIST(IBVISN)
 . ;
 . S IBDIVCNT=0
 . ;
 . S IBDIV=0
 . F  S IBDIV=$O(IBLIST(IBVISN,IBDIV)) Q:'IBDIV  D
 . . ;
 . . S IBIDNO=$$GET1^DIQ(4,IBDIV,99)
 . . S IBNAME=$$GET1^DIQ(4,IBDIV,.01)
 . . S IBNAME=$$NAME(IBNAME)
 . . S IBSTATE=$$GET1^DIQ(4,IBDIV,.02,"I")
 . . S IBSTATE=$$GET1^DIQ(5,IBSTATE,1)
 . . ;
 . . S IBDIVCNT=IBDIVCNT+1
 . . ;
 . . S @IBTEMP@("VISNs",IBVISNCNT,"Divisions",IBDIVCNT,"ID")=IBIDNO
 . . S @IBTEMP@("VISNs",IBVISNCNT,"Divisions",IBDIVCNT,"ID","IEN")=IBDIV
 . . S @IBTEMP@("VISNs",IBVISNCNT,"Divisions",IBDIVCNT,"Name")=IBNAME
 . . S @IBTEMP@("VISNs",IBVISNCNT,"Divisions",IBDIVCNT,"State")=IBSTATE
 . . ;
 . . S IBSTACNT=0
 . . ;
 . . S IBSTATION=0
 . . F  S IBSTATION=$O(IBLIST(IBVISN,IBDIV,IBSTATION)) Q:'IBSTATION  D
 . . . ;
 . . . S IBIDNO=$$GET1^DIQ(4,IBSTATION,99)
 . . . S IBNAME=$$GET1^DIQ(4,IBSTATION,.01)
 . . . S IBNAME=$$NAME(IBNAME)
 . . . S IBSTATE=$$GET1^DIQ(4,IBSTATION,.02,"I")
 . . . S IBSTATE=$$GET1^DIQ(5,IBSTATE,1)
 . . . ;
 . . . S IBSTACNT=IBSTACNT+1
 . . . ;
 . . . S @IBTEMP@("VISNs",IBVISNCNT,"Divisions",IBDIVCNT,"Stations",IBSTACNT,"ID")=IBIDNO
 . . . S @IBTEMP@("VISNs",IBVISNCNT,"Divisions",IBDIVCNT,"Stations",IBSTACNT,"Name")=IBNAME
 . . . S @IBTEMP@("VISNs",IBVISNCNT,"Divisions",IBDIVCNT,"Stations",IBSTACNT,"State")=IBSTATE
 . . . ;
 . . . Q
 . . Q
 . Q
 ;
 ; Call the utility ENCODE to translate the results into valid JSON.
 ;
 D ENCODE^XLFJSON(IBTEMP,RESULT)
 S @RESULT@(1)="["_@RESULT@(1)
 S X=$O(@RESULT@(""),-1)
 S @RESULT@(X)=@RESULT@(X)_"]"
 ;
 Q
 ;
REPORT(EXCEL) ; Build the list and display the results.
 ;
 ; This procedure exists mainly to aid in the development and
 ; testing of the RPC.
 ;
 ; EXCEL - Optional input parameter.  If 1, then the output
 ; will be "^" delimited.
 ;
 N IBLIST,RESULT
 ;
 S RESULT=$NA(^TMP("JSON",$J))
 K @RESULT
 ;
 D VISNS(.IBLIST)
 D DIVISIONS(.IBLIST)
 D STATIONS(.IBLIST)
 ;
 D DISPLAY(.IBLIST,$G(EXCEL))
 ;
 Q
 ;
DISPLAY(IBLIST,EXCEL) ; Display results.
 ;
 N IBCOUNT,IBCPAC,IBDIV,IBDIVNAME,IBDIVNO,IBDIVSTATE,IBSTATION
 N IBSTNIDNO,IBSTNNAME,IBSTNSTATE,IBVISN
 ;
 I '$G(EXCEL) S EXCEL=0
 ;
 ; Set up array of VISN-to-CPAC mapping.
 ;
 I EXCEL D CPACMAP(.IBCPAC)
 ;
 S IBCOUNT=0
 S IBVISN=0
 F  S IBVISN=$O(IBLIST(IBVISN)) Q:'IBVISN  I $D(IBLIST(IBVISN))=11 D
 . ;
 . I 'EXCEL W !!,IBLIST(IBVISN)
 . ;
 . S IBDIV=0
 . F  S IBDIV=$O(IBLIST(IBVISN,IBDIV)) Q:'IBDIV  D
 . . ;
 . . S IBDIVNO=$$GET1^DIQ(4,IBDIV,99)
 . . S IBDIVNAME=$$NAME($$GET1^DIQ(4,IBDIV,.01))
 . . S IBDIVSTATE=$$GET1^DIQ(4,IBDIV,.02,"I")
 . . S IBDIVSTATE=$$GET1^DIQ(5,IBDIVSTATE,1)
 . . ;
 . . I 'EXCEL W !?4,IBDIVNO,?9,IBDIVNAME
 . . ;
 . . S IBSTATION=0
 . . F  S IBSTATION=$O(IBLIST(IBVISN,IBDIV,IBSTATION)) Q:'IBSTATION  D
 . . . ;
 . . . S IBCOUNT=IBCOUNT+1
 . . . S IBSTNIDNO=$$GET1^DIQ(4,IBSTATION,99)
 . . . S IBSTNNAME=$$NAME($$GET1^DIQ(4,IBSTATION,.01))
 . . . S IBSTNSTATE=$$GET1^DIQ(4,IBSTATION,.02,"I")
 . . . S IBSTNSTATE=$$GET1^DIQ(5,IBSTNSTATE,1)
 . . . ;
 . . . I EXCEL D
 . . . . W !,IBCOUNT,"^"
 . . . . W $G(IBCPAC(IBLIST(IBVISN))),"^"
 . . . . W IBLIST(IBVISN),"^"
 . . . . W IBDIVNO,"^"
 . . . . W IBDIVNAME,"^"
 . . . . W IBDIVSTATE,"^"
 . . . . W IBSTNIDNO,"^"
 . . . . W IBSTNNAME,"^"
 . . . . W IBSTNSTATE
 . . . . Q
 . . . E  W !?6,IBSTNIDNO,?13,IBSTNNAME
 . . . ;
 . . . Q
 . . Q
 . Q
 Q
 ;
NAME(IBNAME) ; Strip commas from name.
 ;
 ; Strip commas, and be sure to leave one <space> not two.
 ;
 I $F(IBNAME,", ") S IBNAME=$TR(IBNAME,",")
 I $F(IBNAME,",") S IBNAME=$TR(IBNAME,","," ")
 Q IBNAME
 ;
CPACMAP(IBCPAC) ;
 ;
 ; VISNs 3, 11, 13, 14, and 18 should not exist -- they have each been
 ; merged into other VISNs.  If they do exist, they should be
 ; associated with the CPACs indicated.
 ;
 S IBCPAC("VISN 01")="NORTH EAST CPAC"
 S IBCPAC("VISN 02")="NORTH EAST CPAC"
 S IBCPAC("VISN 03")="NORTH EAST CPAC"
 S IBCPAC("VISN 04")="NORTH EAST CPAC"
 S IBCPAC("VISN 05")="MID-ATLANTIC CPAC"
 S IBCPAC("VISN 06")="MID-ATLANTIC CPAC"
 S IBCPAC("VISN 07")="MID-ATLANTIC CPAC"
 S IBCPAC("VISN 08")="FLORIDA/CARIBBEAN CPAC"
 S IBCPAC("VISN 09")="MID-SOUTH CPAC"
 S IBCPAC("VISN 10")="NORTH CENTRAL CPAC"
 S IBCPAC("VISN 11")="NORTH CENTRAL CPAC"
 S IBCPAC("VISN 12")="NORTH CENTRAL CPAC"
 S IBCPAC("VISN 13")="CENTRAL PLAINS CPAC"
 S IBCPAC("VISN 14")="CENTRAL PLAINS CPAC"
 S IBCPAC("VISN 15")="CENTRAL PLAINS CPAC"
 S IBCPAC("VISN 16")="MID-SOUTH CPAC"
 S IBCPAC("VISN 17")="MID-SOUTH CPAC"
 S IBCPAC("VISN 18")="WEST CPAC"
 S IBCPAC("VISN 19")="CENTRAL PLAINS CPAC"
 S IBCPAC("VISN 20")="WEST CPAC"
 S IBCPAC("VISN 21")="WEST CPAC"
 S IBCPAC("VISN 22")="WEST CPAC"
 S IBCPAC("VISN 23")="CENTRAL PLAINS CPAC"
 ;
 Q
 ;
