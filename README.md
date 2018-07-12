# Point Pattern Matching

Our project consists of 4 files: 2 example and 2 main files. 

ppm.m - file implements ppm function that does point pattern matching 
  algorithm, mentioned in the book, which calculates error of any two datasets 
  that have same dimensions with x, y coordinates, representing rows. The 
  function returns error of given datasets.
  
dataManager.m - file implements dataManager function that gets input from user
  and passes it and given dataset to ppm.m file. The dataset is given as argument
  by cell object that has any number of dataset. These datasets are given to
  ppm one by one together with input.
  
letters.m - has initial cell with letter datasets, which are given to dataManager
  for further processing. After getting results, it displays the predicted
  letter
  
numbers.m - has initial cell with number datasets, which are given to dataManager
  for further processing. After getting results, it displays the predicted
  number.
  
letter.m and numbers.m are given as example how dataManager.m and ppm.m can be
used. They are not mandatory!
