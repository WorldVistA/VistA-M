ORAEHLP ; SPFO/AJB - Alert Enhancements Reports ;Feb 21, 2020@13:04:59
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**518**;Dec 17, 1997;Build 11
 Q
HELP1 ;
 W !!,"Input the entries for filtering.  You may select as many entries as you'd like"
 W !,"separated by a comma.  Enter '??' for more information."
 W !!,"Important Note:  DEFAULT entries have the highest number of notifications for"
 W !,"                 their type.",!
 Q
HELP ;
 I X="?" W ! I '$$READ^ORPARMG1("Y","Would you like detailed info","NO") W ! Q
 N TXT,X,Y S Y="HLPT"
 F X=1:1 S TXT=$P($T(@Y+X),";;",2) Q:TXT="EOM"  D
 . S TXT(X)=TXT
 D DISPLAY(.TXT)
 W @IOF
 Q
HLPT ;
 ;;Enter one or more of the data types you'd like to filter separated by a comma.
 ;;
 ;;You only have to enter the first letter of each filter type if you wish.
 ;;
 ;;Example selecting RECIPIENT and NOTIFICATION:
 ;;
 ;;     Filter by:  RECIPIENT// R,N   RECIPIENT  NOTIFICATION
 ;;
 ;;Example selecting ALL:
 ;;
 ;;     Filter by:  RECIPIENT// all   DIVISION  LOCATION  NOTIFICATION
 ;;                                   RECIPIENT  SERVICE  TITLE
 ;;
 ;;If you would like to see a particular data field in the output, you may also
 ;;add it as a FILTER criteria and enter ALL.  This will add that data field to
 ;;the display output but include all entries regardless of their value.
 ;;
 ;;If you would only like to see entries with a particular value in a data field,
 ;;add it as a FILTER and then enter one or more of the values you wish to see
 ;;displayed in the data.
 ;;
 ;;
 ;;Example default output for a recipient and notification (no filters):
 ;;
 ;;    USER,ONE
 ;;      CONSULT/REQUEST RESOLUTION                                              17
 ;;      ORDER REQUIRES ELECTRONIC SIGNATURE                                     19
 ;;
 ;;Example output using the following FILTER:
 ;;
 ;;Select report type: SUMMARY// FILTERED
 ;;
 ;;Filter by:  RECIPIENT// R,T     RECIPIENT,TITLE
 ;;
 ;;RECIPIENT:  USER ONE//     USER ONE,USER TWO  <--Filtering for 2 specific users.
 ;;
 ;;TITLE:  COMPUTER SPECIALIST// ALL    <--Adding ALL titles to the filter.
 ;;
 ;;    USER,ONE [COMPUTER SPECIALIST]   <--TITLE has been added to the output.
 ;;      CONSULT/REQUEST RESOLUTION                                              17
 ;;      ORDER REQUIRES ELECTRONIC SIGNATURE                                     19
 ;;
 ;;    USER,TWO [PROVIDER]              <--TITLE has been added to the output.
 ;;      NEW SERVICE CONSULT/REQUEST                                             11
 ;;
 ;;You may add any additional data fields to the display output simply by adding
 ;;the data type as a FILTER and entering ALL as the criteria.
 ;;
 ;;Important note:  The filter criteria is inclusive so that when you enter a value
 ;;                 to filter you will only get entries with that value in the
 ;;                 display!
 ;;
 ;;                 If you enter more than one criteria and don't enter ALL, any
 ;;                 data must match ALL the filters you enter.
 ;;
 ;;Example:  Filter by:  RECIPIENT// t,s   TITLE  SERVICE
 ;;          TITLE: COMPUTER SPECIALIST//    COMPUTER SPECIALIST
 ;;          SERVICE: INFORMATION SYSTEMS CENTER//    INFORMATION SYSTEMS CENTER
 ;;
 ;;    Your results will only contain RECIPIENTS that have the title COMPUTER
 ;;    SPECIALIST *AND* with the service INFORMATION SYSTEMS CENTER.
 ;;
 ;;Lastly, the data is either RECIPIENT or NOTIFICATION based.  You can choose to
 ;;focus on one or the other by the order in which you add them to the filter.
 ;;
 ;;
 ;;                         ** Important Information **
 ;;
 ;;"Data Not Available" may be selectable as FILTER criteria in some cases.
 ;;This occurs when the notification points to data in an ORDER or DOCUMENT that
 ;;was never completed/signed and is no longer available.  This may happen with
 ;;filtering by DIVISION or LOCATION.  It is not an error and indicates that the
 ;;information is no longer available.
 ;;
 ;;EOM
 ;;        10        20        30        40        50        60        70        80
 Q
HDR1 ;
 I $E(IOST,1,2)="C-" D
 . R !,"Press <ENTER> to continue or '^' to exit ",X:DTIME S END='$T!(X=U)
 Q:+END
HDR2 W:$E(IOST,1,2)="C-" @IOF
 Q
DISPLAY(OUTPUT) ;
 N END,Y
 S (END,Y)=0
 D:$E(IOST,1,2)="C-" HDR2
 F  S Y=$O(OUTPUT(Y)) Q:'+Y!(+END)  D
 . D HDR1:$Y+3>IOSL Q:+END  W OUTPUT(Y),!
 Q:+END
 I $E(IOST,1,2)="C-",IOSL'>24 F  Q:$Y+3>IOSL  W !
 R:$E(IOST,1,2)="C-" !,"Help information complete.  Press <Enter> to continue ",X:DTIME
 Q
