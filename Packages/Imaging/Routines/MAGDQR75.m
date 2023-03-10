MAGDQR75 ;WOIFO/PMK - Imaging RPCs for Query/Retrieve - acc# lookup for lab (anatomic pathology) ; Feb 15, 2022@10:27:57
 ;;3.0;IMAGING;**305**;Mar 19, 2002;Build 3
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
 ; called from MAGDQR07
 ;
ACCLAB(REQ,T,P,ACC) ; scan for Laboratory Related Images
 N I,OUT,NOUT
 ;
 ; Lab accession numbers have "abbr yy nnnnnnn" format
 Q:$L(P," ")'=3  Q:P'?.E1" "2N1" "1N.N
 ;
 K OUT S NOUT=0 D LABLKUP^MAGDRPC4(.NOUT,.OUT,.ACNUMB,P)
 F I=1:1:NOUT D
 . S ^TMP("MAG",$J,"QR",6,"C^^"_OUT(I))="",ACC=1
 . Q
 Q
