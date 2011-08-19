MAGGTSY2 ;WOIFO/GEK - Calls from Imaging windows for System Manager ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
MAG(MAGRY,NODE) ;RPC Call to show node of Image File
 ;  NODE is the IEN of Image File :  ^MAG(2005,NODE
 N Y,I,CT,X,TNODE
 S MAGRY=$NA(^TMP("MAGNODE",$J))
 S NODE=$G(NODE)
 N I,CT,X
 K @MAGRY
 S @MAGRY@(0)="Display NODE: "_$S($L(NODE):NODE,1:"LAST")
 S I=0,CT=0
 I $E(NODE)="^" G OTH
 I 'NODE S NODE=$P(^MAG(2005,0),U,3)
 S I="^MAG(2005,"_NODE_","""")"
 F  S X=$Q(@I) S I=X Q:$P(X,",",2)'=NODE  D
 . S CT=CT+1,@MAGRY@(CT)=X_" "_@X
 . Q
 I $P($G(^MAG(2005,NODE,2)),"^",6)="8925" D
 . S CT=CT+1,@MAGRY@(CT)="   *******   TIU    ******* "
 . S TNODE=$P(^MAG(2005,NODE,2),"^",7)
 . S I="^TIU(8925,"_TNODE_","""")"
 . F  S X=$Q(@I) S I=X Q:$P(X,",",2)'=TNODE  D
 . . S CT=CT+1,@MAGRY@(CT)=X_" "_@X
 . . Q
 Q
OTH ;
 N OTHDA
 S OTHDA=$P(NODE,",",2)
 I OTHDA=0 S NODE=NODE_")" Q:'$D(@NODE)  S CT=$O(@MAGRY@(""),-1)+1,@MAGRY@(CT)=$G(@(NODE)) Q
 S I=NODE_","""")"
 F  S X=$Q(@I) S I=X Q:$P(X,",",2)'=OTHDA  D
 . S CT=$O(@MAGRY@(""),-1)+1,@MAGRY@(CT)=X_" "_@X
 . Q
 Q
