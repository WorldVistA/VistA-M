MAGDHL7T ;WOIFO/LB - Routine to create HL7 message header ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;;Mar 01, 2002
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
EN ;
 I '$D(HLERR1) S HLEVN=1,HLSDATA(0)=$$MSH^HLFNC1($G(HLMTN),$G(HLSEC)) D
 . I $D(HLSDT) S ^TMP("HLS",$J,HLSDT,0)=HLSDATA(0) K HLSDATA
PACS I $G(HLDAN)="PACS GATEWAY" D ENTRY^MAGDHL7
 K HLERR1,HLI,HLI0,HLMSA,HLXMZ
 Q
