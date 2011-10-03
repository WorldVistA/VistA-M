TIUVSITH ; SLC/JER - Help for Interactive Visit look-up ;2/11/99@10:18:21
 ;;1.0;TEXT INTEGRATION UTILITIES;**39**;Jun 20, 1997
HELP(X) ; Offer help
 W !!?3,"Indicate the visit with which the document is associated by choosing"
 W !?3,"the corresponding number."
 W !!?3,"To add a new visit (e.g., for unscheduled or telephone contacts), enter ""N""."
 I '(+$G(TIUII)#20) D
 . W !!?3,"To see MORE, older visits (i.e., beyond the 20 most recent) enter ""M""."
 W !!?3,"To see UNSCHEDULED visits (i.e., those entered as standalone AMBULATORY"
 W !?3,"or TELEPHONE visits for a previous note) enter ""U""."
 I +$P(TIUPRM0,U,14) D
 . W !!?3,"Finally, to extend your view of FUTURE appointments (e.g., cancellations"
 . W !?3,"requiring documentation, etc.), enter ""F"".",!!
 Q
SELHLP ; Help for SELLOC
 W !,"Please indicate the location of your encounter with the patient."
 W !,"If the encounter was by telephone, but was associated with your"
 W !,"services for a particular Ward or Clinic, then enter the name"
 W !,"of that location."
 Q
