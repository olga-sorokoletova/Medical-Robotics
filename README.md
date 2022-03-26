<h1 align="center">Adult/Child Musculoskeletal Model and Motion Analysis Comparison</h1>

This is the repository of the project proposed for the course of *Medical Robotics*.

1. Given the scaled model of a **CHILD** reconstructed through the different walking experiments within an [**OpenSim**](https://simtk.org/) environment **interfacing OpenSim-Matlab** has been performed and an equivalent **kinematic model in Matlab** has been implemented. The aim was to provide a visual representation, which is useful for the **detection of gait peculiarities**. 

2. Additionally, **ADULT kinematic model** has been implemented based on the kinematic and MOCAP (Motion Capture) marker data. 

3. A **comparative motion analysis** between the child and the adult has been performed.

For the further theoretical information on the project please refer to the [```Report/```](https://github.com/olga-sorokoletova/Medical-Robotics/tree/main/Report) or take a look at the [```Presentation/```](https://github.com/olga-sorokoletova/Medical-Robotics/tree/main/Presentation). To see the code implementation, check the [```Matlab Files/```](https://github.com/olga-sorokoletova/Medical-Robotics/tree/main/Matlab%20Files).

## Run the project

In the current section an overview of each script in the [```Matlab Files/```](https://github.com/olga-sorokoletova/Medical-Robotics/tree/main/Matlab%20Files) is given. In order to run them, make sure to change the path of each fopen function such that it is the path of the chosen file in your machine.

___

### Sirine (Child) model file:

**Code:** [Sirine_model.m](https://github.com/olga-sorokoletova/Medical-Robotics/blob/main/Matlab%20Files/Sirine_model.m).

**Purpose:** to visualize the information contained inside the file with marker data that we had for the child.

**Variables:**
```
----rows---- is a cell structure of a fixed length which is the number of rows contained inside the file.
----m_cols---- is an array containing the columns of the file, the time series of x,y,z marker coordinates.
----ground---- are the arrays containing all the vaues needed to plot the ground reference frame.
----r---- is the frame rate, obtained by the robotic tool, we need it to display the animation.
----t---- is the time array, containing all the time frames.
```

It is possible to choose a specific camera view by decommenting the specific portion of the code.

#### Animated Model of Sirine

<p align="center">
  <img src="/Animations/SirineModelDynamic.gif" width="800" height="420"/>
</p>

___

### Adult model file:

**Code:** [Adult_model.m](https://github.com/olga-sorokoletova/Medical-Robotics/blob/main/Matlab%20Files/Adult_model.m).

**Purpose:** to visualize the information contained inside the files with marker data an kinematic data that we had for the adult.

**Variables:**
```
----rows---- is a cell structure of a fixed length which is the number of rows contained inside the file.
---- k_cols---- is an array containing the columns of the file, the time series of x,y,z joint origin coordinates.
---- a_cols---- is an array containing the columns of the file, the time series of the i,j element of the rotation matrix expressing the orientation of the a given joint reference frame w.r.t the parental one.
----m_cols---- is an array containing the columns of the file, the time series of x,y,z marker coordinates.
----ground---- are the arrays containing all the vaues needed to plot the ground reference frame.
----r---- is the frame rate, obtained by the robotic tool, we need it to display the animation.
----t---- is the time array, containing all the time frames.
```

It is possible to choose a specific camera view by decommenting the specific portion of the code.

#### Animated Model of Adult

<p align="center">
  <img src="/Animations/AdultModelDynamic.gif" width="800" height="420"/>
</p>

___

### Cartesian Comparison file:

**Code:** [Cartesian_comparison.m](https://github.com/olga-sorokoletova/Medical-Robotics/blob/main/Matlab%20Files/Cartesian_comparison.m).

**Purpose:** to unify Sirine and Adult model.

**Variables:**
```
----rows---- is a cell structure of a fixed length which is the number of rows contained inside the file.
---- k_cols---- is an array containing the columns of the file, the time series of x,y,z joint origin coordinates.
----m_cols_S---- is an array containing the columns of the file, the time series of x,y,z marker coordinates for Sirine.
----m_cols---- is an array containing the columns of the file, the time series of x,y,z marker coordinates for Adult
----ground---- are the arrays containing all the vaues needed to plot the ground reference frame.
----r---- is the frame rate, obtained by the robotic tool, we need it to display the animation.
----t---- is the time array, containing all the time frames.
```

#### Animated Cartesian Comparison

<p align="center">
  <img src="/Animations/cartesianComparison.gif" width="800" height="420"/>
</p>

___

### Marker Comparison file:

**Code:** [Markers_comparison.m](https://github.com/olga-sorokoletova/Medical-Robotics/blob/main/Matlab%20Files/Markers_comparison.m).

**Purpose:** to plot specific marker trajectory to compare them. 

**Variables:**
```
----rows---- is a cell structure of a fixed length which is the number of rows contained inside the file.
----s_cols---- is an array containing the columns of the file, the time series of x,y,z marker coordinates for Sirine.
----a_cols---- is an array containing the columns of the file, the time series of x,y,z marker coordinates for Adult
----ground---- are the arrays containing all the vaues needed to plot the ground reference frame.
```

In order to plot a specific marker evolution the associated control variable must be set to *true*.

#### Animated Marker Comparison

Example of a Marker Plotting Animation for the Ankle:

<p align="center">
  <img src="/Animations/MarkerComparison_LAJC_S_RAJC_S.gif" width="800" height="420"/>
</p>

Example of a Marker Plotting Animation for the Torso:

<p align="center">
  <img src="/Animations/MarkerComparisonTorso.gif" width="800" height="420"/>
</p>

___

### Angles Comparison file:

**Code:** [Angles_comparison.m](https://github.com/olga-sorokoletova/Medical-Robotics/blob/main/Matlab%20Files/Angles_comparison.m).

**Purpose:** to unify Sirine and Adult model

**Variables:**
```
----rows---- is a cell structure of a fixed length which is the number of rows contained inside the file.
----s_angles---- is an array containing the columns of the file, the time series of angles for Sirine.
----a_cols---- is an array containing the columns of the file, the time series of the i,j element of the rotation matrix expressing the orientation of the a given joint reference frame w.r.t the parental one.
----a_angles---- is an array containing the angles obtained by a_cols, solution of the inverse kinematic problem.
----t---- is the time array, containing all the time frames.
```
In order to plot a specific angle evolution the associated control variable must be set to *true*.

#### Animated Angles Comparison

Example of a Joint Angle Plotting Animation for the Knee:

<p align="center">
  <img src="/Animations/AngleComparisonKnee.gif" width="800" height="420"/>
</p>

___

## Authors
- Olga Sorokoletova - 1937430
- Lorenzo Mandelli - 1747091
- Yannick Moell - 1979142
- Giulio Recupito - 1668320
