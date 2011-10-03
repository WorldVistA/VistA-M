MAGGTU41 ;WOIFO/GEK/SG - VERSION CONTROL UTILITIES  ; 3/04/10 4:25pm
 ;;3.0;IMAGING;**46,59,93,90**;Mar 19, 2002;Build 1764;Jun 09, 2010
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;+++++ CHECKS THE CLIENT VERSION AGIANST THE LIST OF SUPPORTED ONES
 ;
 ; .VCD          Reference to a local variable where the version
 ;               control data is cached (see the $$GETVCD^MAGGTU41
 ;               for details).
 ;
 ; CLNAME        Client name ("CAPTURE", "CLUTILS", "DISPLAY",
 ;               "TELEREADER", or "VISTARAD")
 ;
 ; .CLVER        Reference to a local variable that stores the client
 ;               application version (Major.Minor.Patch.Build).
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see $$ERROR^MAGUERR)
 ;            0  Latest version of the client
 ;            1  Latest version but old build (T-version)
 ;            2  Supported version of the client
 ;            3  Supported version but old build (T-version)
 ;            4  Client is not supported
 ;
CHKVER1(VCD,CLNAME,CLVER) ;
 N CT,CV,RC
 ;--- Bug in patch 42: the version comes in as 30.5.42.x
 ;--- (patch 42 was not released)
 S:$P(CLVER,".")="30" CLVER="3.0."_$P(CLVER,".",3,99)
 ;--- Parse the client version
 S CV=$P(CLVER,".",1,3),CT=$P(CLVER,".",4)
 S:CT="" $P(CLVER,".",4)=0,CT=0
 ;--- Get the version control data (if not cached already)
 I $D(VCD(CLNAME))<10  S RC=$$GETVCD(.VCD,CLNAME)  Q:RC<0 RC
 ;--- Client and server versions are different
 I CV'=VCD(CLNAME,"SV")  D  Q RC
 . S RC=$S('$D(VCD(CLNAME,"ST",CV)):4,CT<VCD(CLNAME,"ST",CV):3,1:2)
 . Q
 ;--- The versions are the same
 Q $S(CT&(CT'=VCD(CLNAME,"ST")):1,1:0)
 ;
 ;##### RETURNS THE CLIENT APPLICATION DESCRIPTOR
 ;
 ; CLNAME        Client application name
 ;
 ;               If this parameter is not defined or empty, then the
 ;               function returns the list of supported client names
 ;               separated by commas.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see $$ERROR^MAGUERR)
 ;          ...  Client descriptor
 ;                 ^01: Name of the version control routine
 ;                 ^02: Number of the version field in the IMAGING
 ;                      WINDOWS WORKSTATIONS  file (2006.81)
 ;                 ^03: Number of the date/time field in the IMAGING
 ;                      WINDOWS WORKSTATIONS  file (2006.81)
 ;
CLADESC(CLNAME) ;
 Q:$G(CLNAME)="" "CAPTURE,CLUTILS,DISPLAY,TELEREADER,VISTARAD"
 N DSC
 D
 . I CLNAME="CAPTURE"     S DSC="MAGGTU4C^9.5^5.5"  Q
 . I CLNAME="CLUTILS"     S DSC="MAGGTU4L^9.9^5.9"  Q
 . I CLNAME="DISPLAY"     S DSC="MAGGTU4D^9^5"      Q
 . I CLNAME="TELEREADER"  S DSC="MAGGTU4T^9.3^5.3"  Q
 . I CLNAME="VISTARAD"    S DSC="MAGJTU4V^9.7^5.7"  Q
 . Q
 ;
 Q $S($G(DSC)'="":DSC,1:$$ERROR^MAGUERR(-24,,CLNAME))
 ;
 ;+++++ BUILDS THE GENERAL ERROR MESSAGE IN THE RESULT ARRAY
 ;
 ; .MAGRES       Reference to the RPC result array where
 ;               the error message is returned to.
 ;
 ; ERR           Error descriptor (see $$ERROR^MAGUERR)
 ;
ERROR(MAGRES,ERR) ;
 Q:ERR'<0
 N MAGPRMS  K MAGRES
 S MAGPRMS("ERRMSG")=$P(ERR,U,2)  ; Message text
 S MAGPRMS("ERRLOC")=$P(ERR,U,3)  ; Location
 D BLD^DIALOG(20050005.002,.MAGPRMS,,"MAGRES")
 S MAGRES(0)="2^"_$G(MAGRES(1))  K MAGRES(1)
 Q
 ;
 ;+++++ RETURNS THE ROW OF THE CLIENT VERSION CONTROL TABLE
 ;
 ; ROW           Sequential number of the row (starting from 1)
 ;
 ; Input Variables
 ; ===============
 ;   MAGRTN
 ;
GETVCL(ROW) ;
 Q $P($T(@("CLVERCT+"_(ROW+3)_"^"_MAGRTN)),";;",2)
 ;
 ;##### RETURNS THE SERVER VERSION AND THE LIST OF SUPPORTED CLIENTS
 ;
 ; .VCD(         Reference to a local variable where the version
 ;               control data is returned to.
 ;   CLNAME,
 ;     "SV")     Server version (Major.Minor.Patch.Build)
 ;     "ST",     Server build number (T-version)
 ;       Ver)    Build number of the version Ver release.
 ;               Ver is in the Major.Minor.Patch format.
 ;
 ; CLNAME        Client name ("CAPTURE", "CLUTILS", "DISPLAY",
 ;               "TELEREADER", or "VISTARAD")
 ;
 ;               See also the CLVERCT^MAGGTU4C, CLVERCT^MAGGTU4D,
 ;               CLVERCT^MAGGTU4L, and CLVERCT^MAGGTU4T for client
 ;               specific version tables.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see $$ERROR^MAGUERR)
 ;            0  Success
 ;
GETVCD(VCD,CLNAME) ;
 N MAGRTN        ; Name of the routine with the version control table
 ;
 N BUF,I,SV,TMP,VER   K VCD(CLNAME)
 F I="ST","SV"  S VCD(CLNAME,I)=""
 ;
 ;=== Get the name of the routine that contains the
 ;=== version control table for the client
 S MAGRTN=$P($$CLADESC(CLNAME),U)  Q:MAGRTN<0 MAGRTN
 ;
 ;=== Get the server version from the second line of the
 ;=== routine that contains the version control table
 S BUF=$P($T(@("+2^"_MAGRTN)),";;",2,999)
 Q:BUF="" $$ERROR^MAGUERR(-25,,MAGRTN)
 ;--- Get the package version
 S SV=$TR($P(BUF,";")," ")
 ;--- Get the patch number (the last one) from the list
 S TMP=$TR($P($P(BUF,";",3),"**",2)," ")
 S SV=SV_"."_(+$P(TMP,",",$L(TMP,",")))
 ;
 ;=== Load the version control table
 F I=1:1  S BUF=$$GETVCL(I)  Q:BUF=""  D
 . S BUF=$TR(BUF,"| ",U),VER=$P(BUF,U,2)
 . S:VER>0 VCD(CLNAME,"ST",VER)=+$P(BUF,U,3)
 . Q
 ;
 ;=== Get the build number and remove the server version from the list
 S VCD(CLNAME,"SV")=SV
 S VCD(CLNAME,"ST")=+$G(VCD(CLNAME,"ST",SV))
 K VCD(CLNAME,"ST",SV)
 Q 0
 ;
 ;+++++ APPENDS THE CLIENT-SPECIFIC WARNING TO THE ARRAY
 ;
 ; .MAGRES       Reference to the RPC result array that
 ;               the warning is apppended to.
 ;
 ; CLNAME        Client name
 ;
 ; CLVER         Client application version (Major.Minor.Patch.Build)
 ;
 ; CVRC          Version check code returned by the $$CHKVER1^MAGGTU41
 ;
WARNING(MAGRES,CLNAME,CLVER,CVRC) ;
 ;--- Do not append the warning if the RPC result array already
 ;--- contains an error message that will terminate the client.
 Q:+$G(MAGRES(0),1)=2
 ;
 N EP,MAGBUF,RI,SPI
 S:$P(CLVER,".",4)="" $P(CLVER,".",4)=0
 ;--- Get the name of the client's version control routine
 S EP=$P($$CLADESC(CLNAME),U)  Q:EP<0
 S EP="WARNING^"_EP  Q:$T(@EP)=""
 ;--- Get the client-specific warning
 X "D "_EP_"(.MAGBUF,CLVER,CVRC)"
 S SPI=$Q(MAGBUF)  Q:SPI=""
 ;--- Append the 1st line of the warning text to the result array
 ;--- and make sure that the client will diplay the warning
 S RI=$O(MAGRES(""),-1)
 I RI'=""  D  S:+$G(MAGRES(0),1)=1 $P(MAGRES(0),U)=0
 . S RI=RI+1,MAGRES(RI)=" "
 . S RI=RI+1,MAGRES(RI)=@SPI
 . Q
 E  S MAGRES(0)="1^"_@SPI
 ;--- Append the remaining lines
 F  S SPI=$Q(@SPI)  Q:SPI=""  S RI=RI+1,MAGRES(RI)=@SPI
 Q
