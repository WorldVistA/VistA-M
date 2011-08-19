RTT21 ;ISC-ALBANY/PKE-Record Transaction Option cont; ; 9/10/90  14:24 ;
 ;;v 2.0;Record Tracking;;10/22/91 
 ;set up check-in pending cut-off positive logic reverts to origial
 ;if no pending checkin parameters set
INI S RTCHKDT=$S(RTMV0'["CHECK-IN":RTWND(Y),1:$S((RTWND(Y)>DT):DT,1:RTWND(Y)))
 S X1=RTCHKDT,X2=-1 D C^%DTC S RTCHKDT=X
 S RTDT=$S(RTMV0'["CHECK-IN":DT,1:$S((RTWND(Y)>DT):RTWND(Y),1:DT))
 ;
 ;S RTCHKDT=$S(RTMV0'["CHECK-IN":(RTWND(Y)-1),1:$S((RTWND(Y)>DT):(DT-1),1:(RTWND(Y)-1)))
 ;S RTDT=$S(RTMV0'["CHECK-IN":DT,1:$S((RTWND(Y)>DT):RTWND(Y),1:DT))
 ;dtm=dt-1,winm=rtwnd(y)-1
