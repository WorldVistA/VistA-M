MAGDFB ;WOIFO/EdM - Call MAGFILEB ; 04/29/2005  08:55
 ;;3.0;IMAGING;**11,51**;26-August-2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; The purpose of this subroutine is to call FINDFILE in MAGFILEB
 ; in such a way that all parameters are passed in or out,
 ; and such that all internal variables of MAGFILEB are NEWed
 ;
FILEFIND(MAGXX,FILETYPE,MAGJBCP,VERBOSE,MAGFILE1,MAGFILE2,MAGFILE) ;
 ; Input:
 ;  MAGXX     -- IEN into file 2005, ^MAG(2005,IEN,0)
 ;  FILETYPE  -- "FULL", "ABSTRACT" or "BIG"
 ;  MAGJBCP   -- Flag: do or don't copy from JukeBox to HardDisk
 ;  VERBOSE   -- Flag: do or don't display interactive error messages
 ; Output:
 ;  MAGFILE1  -- filename
 ;  MAGFILE2  -- path + filename
 ;  MAGFILE   -- path + filename + $C(0)
 ;  MAGPLACE  -- pointer to ^MAG(2006.1) for "place" where image is stored
 ;  MAGINST   -- pointer to ^DIC(4) that corresponds to MAGPLACE
 ;
 N MAGJBOL,MAGOFFLN,MAGPREF,MAGTYPE
 D FINDFILE^MAGFILEB
 S MAGFILE2=$G(MAGPREF)_MAGFILE1,MAGFILE=MAGFILE2_$C(0)
 Q
 ;
