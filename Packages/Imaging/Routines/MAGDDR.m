MAGDDR ;WOIFO/NST FileMan Delphi Components' RPCs ;4/28/98  10:38
 ;;3.0;IMAGING;**114**;Mar 19, 2002;Build 1827;Aug 17, 2010
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
LISTC(MAGOUT,MAGDDR) ; RPC[MAGDDR LISTER] -- broker callback to get list data
 D LISTC^DDR(.MAGOUT,.MAGDDR)
 Q
 ;
GETSC(MAGOUT,MAGDDR) ; RPC[MAGDDR GETS ENTRY DATA]
 D GETSC^DDR2(.MAGOUT,.MAGDDR)
 Q
