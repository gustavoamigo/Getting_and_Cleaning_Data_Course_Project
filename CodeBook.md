Code Book
=========

### dataset.txt
It the processed file in tiddy data long format.

**Colums:**
 * **activity** - Activity performed by the person when the value was captured. It can be:
      "STANDING", "SITTING","LAYING","WALKING","WALKING\_DOWNSTAIRS","WALKING\_UPSTAIRS" 
 * **subject** - It is the subject that was captured by the mobile phone
 * **aggregate_function** - It is the aggregate function used to summurize the information. It can be "mean" or "std".
 * **axe** - It is the axe of the subject captured. It NA if the concept does not apply to the subject
 * **value** - It is the actual value captured

### summary_dataset.txt
It the summarized version of the dataset in a wide format.

**Colums:**
 * **activity** - Activity performed by the person when the value was captured. It can be:
      "STANDING", "SITTING","LAYING","WALKING","WALKING\_DOWNSTAIRS","WALKING\_UPSTAIRS" 
 * **subject** - It is the subject that was captured by the mobile phone
 * **axe** - It is the axe of the subject captured. It NA if the concept does not apply to the subject
 * **mean** - It is the mean of the means
 * **std** - It is the mean of the std
