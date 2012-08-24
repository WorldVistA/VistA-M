DVB4P66E ;ALB/RC - DISABILITY FILE UPDATE - Environment Check ; 11/1/10 5:28pm
 ;;4.0;HINQ;**66**;03/25/92;Build 14
 ;Checks environment to make sure that it is ok to install patch
 W !,"Running Environment Check."
ENV ;Check programmer variables
 I ($G(DUZ))&($G(DUZ(0))="@")&($G(DT))&($G(U)="^") D  Q
 .W !,"Environment Check completed successfully.",!
 W !!,"Your programming variables are not set up properly.",!
 I '$G(DUZ) W !,"DUZ is not set properly."
 I $G(DUZ(0))'="@" W !,"DUZ(0) is not set to @."
 I '$G(DT) W !,"DT is not set."
 I $G(U)'="^"  W !,"U is not set properly."
 W !!,"Installation aborted.",!
 S XPDABORT="2"
 Q
