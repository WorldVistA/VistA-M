MAGGTU4M ;WOIFO/GEK - MUSE3 VIEWER UTILITIES
 ;;3.0;IMAGING;**188**;Mar 19, 2002;Build 61;Mar 18, 2018
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
 ; This routine contains Utilities for the MUSE FORMAT TABLE
 ;
 Q
 ;
 ;  The default Format ID's listed below are used to generate the
 ;  MUSE Test for the specified Test Type.
 ;  If Site Specific Format ID's have been entered into the 
 ;  MUSE FORMAT TABLE, those Format ID's will override the defaults
 ; 
 ; ***** DEFAULTS for Test Type -> Format ID mapping 
 ;;===============================================================
 ; Test Type    Grid    Format ID
 ; RestingECG     Y        6
 ; Stress         Y        7
 ; Holter         Y        8
 ; HiRes          Y        9
 ; RestingECG     N        12
 ; HiRes          N        13
 ; Stress         N        14
 ; Holter         N        15
 ;;===============================================================
 ;
NETLOC(MAGRY,IEN) ;RPC [MAG4 GET NETLOC INFO]
 ; Gets info from Network Location file.
 ; IEN is the Internal Entry Number in the NETWORK LOCATION File
 ;
 ; The Return String is in the format :
 ; .01 Description  ^  Physical Reference ^ Operational Status  (OnLine/OffLine)
 N IC,FNUM,MAGZZ,MAGERR
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 S FNUM="2005.2"
 K MAGRY
 I '$G(IEN) D  Q  ;
 . S MAGRY="0^INVALID Input: "_IEN
 . Q
 I '$D(^MAG(2005.2,IEN,0)) D  Q  ;
 . S MAGRY="0^INVALID NETWORK LOCATION Entry: "_IEN
 . Q
 K MAGZZ,MAGERR
 D GETS^DIQ(FNUM,IEN,".01;1;5","EI","MAGZZ","MAGERR")
 S IC=IEN_","
 S MAGRY="1^"_MAGZZ(FNUM,IC,".01","E")_"^"_IEN_"^"_MAGZZ(FNUM,IC,"1","E")_"^"_MAGZZ(FNUM,IC,"5","E")
 Q
TABLE(MAGRY,IEN) ;RPC [MAG4 GET MUSE TABLE]
 ;  IEN is the Internal Entry Number in the NETWORK LOCATION File.
 ;  This will return all MUSE FORMAT TABLE entries for the IEN.
 ;    or
 ;  IEN = 'SITE'
 ;  This will return MUSE FORMAT TABLE entries that are defined for
 ;  MUSE Sites.
 ;    or
 ;  IEN = 'ALL'
 ;  This will return an Array, including the Default Format mapping
 ;  in a format that can be shown to the user.
 ;
 N I,CT,NETLOC,IC,FNUM,MAGZZ,MAGERR
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 S FNUM="2006.172"
 S CT=0
 K MAGRY
 I IEN="ALL" D ALL Q  ;
 I IEN="SITE" D SITE Q  ;
 I '$G(IEN) D  Q  ;
 . S MAGRY(0)="0^INVALID Input: "_IEN
 . Q
 I '$D(^MAG(2005.2,IEN,0)) D  Q  ;
 . S MAGRY(0)="0^INVALID NETWORK LOCATION Entry: "_IEN
 . Q
 S NETLOC=$P(^MAG(2005.2,IEN,0),"^",1)
 I '$D(^MAG(2006.172,"C",IEN)) D  Q  ;
 . S MAGRY(0)="0^There are no MUSE FORMAT TABLE entries for: "_NETLOC_" ("_IEN_")"
 . Q
 S I="" F  S I=$O(^MAG(2006.172,"C",IEN,I)) Q:'I  D  ;
 . K MAGZZ,MAGERR
 . D GETS^DIQ(FNUM,I,".01;1;2;3;4","EI","MAGZZ","MAGERR")
 . S CT=CT+1
 . S IC=I_","
 . S MAGRY(CT)=MAGZZ(FNUM,IC,1,"E")_"^"_IEN_"^"_MAGZZ(FNUM,IC,2,"E")
 . S MAGRY(CT)=MAGRY(CT)_"^"_MAGZZ(FNUM,IC,3,"E")_"^"_MAGZZ(FNUM,IC,4,"E")
 . Q
 I CT=0 S MAGRY(0)="0^0 Entries in MUSE FORMAT TABLE for: "_MAGZZ(FNUM,IC,1,"E")_" ("_IEN_")"
 I CT>0 S MAGRY(0)="1^"_CT_" MUSE FORMAT TABLE Entries for: "_MAGZZ(FNUM,IC,1,"E")_" ("_IEN_")"
 Q
SITE ;called internally
 ; We get here if user wants ALL MUSE FORMAT TABLE Entered at this VistA Site.
 S MAGRY(0)="1^Returning All entries in MUSE FORMAT TABLE"
 N J
 S J=0
 F  S J=$O(^MAG(2006.172,J)) Q:'J  D  ;
 . K MAGZZ,MAGERR
 . D GETS^DIQ(FNUM,J,".01;1;2;3;4","EI","MAGZZ","MAGERR")
 . S CT=CT+1
 . S IC=J_","
 . S MAGRY(CT)=MAGZZ(FNUM,IC,1,"E")_"^"_MAGZZ(FNUM,IC,1,"I")_"^"_MAGZZ(FNUM,IC,2,"E")
 . S MAGRY(CT)=MAGRY(CT)_"^"_MAGZZ(FNUM,IC,3,"E")_"^"_MAGZZ(FNUM,IC,4,"E")
 . Q
 I CT=0 S MAGRY(0)="0^0 Entries in MUSE FORMAT TABLE."
 I CT>0 S MAGRY(0)="1^"_CT_" MUSE FORMAT TABLE Entries."
 Q
ALL ;called internally
 ; This function will return an array of MUSE FORMAT TABLE entries for Display
 ; to the user.
 ; This Array will include the 'Default' values that are used, and any 
 ; Site Specific entries in the MUSE FORMAT TABLE File.
 ;
 S MAGRY(1)="Site^IEN^Test Type^Grid^Format ID"
 S MAGRY(2)="All Sites^0^RestingECG^Yes^6"
 S MAGRY(3)="All Sites^0^Stress^Yes^7"
 S MAGRY(4)="All Sites^0^Holter^Yes^8"
 S MAGRY(5)="All Sites^0^HiRes^Yes^9"
 ;
 S MAGRY(6)="All Sites^0^RestingECG^No^12"
 S MAGRY(7)="All Sites^0^HiRes^No^13"
 S MAGRY(8)="All Sites^0^Stress^No^14"
 S MAGRY(9)="All Sites^0^Holter^No^15"
 S CT=9
 D SITE
 S MAGRY(0)="1^All Format Table entries, including the Default Format IDs."
 Q
