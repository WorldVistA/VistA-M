YS31POST ;DALCIOFO/MJD-PATCH YS*5.01*31 POST RTN. ;09/23/97
 ;;5.01;MENTAL HEALTH;**31**;Dec 30, 1994
 ;
 ; Unless the site has modified this file the zero node
 ; for file #601 MH INSTRUMENT should look like:
 ; ^YTT(601,0) = MH INSTRUMENT^601^233^88
 S:$P(^YTT(601,0),U,3)="225" $P(^YTT(601,0),U,3)=233
 S $P(^YTT(601,0),U,4)=$P(^YTT(601,0),U,4)+8
 ;
 QUIT
