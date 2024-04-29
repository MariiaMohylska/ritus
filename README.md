# RITUS

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

Ritus is an mobile application designed to help  build and track        positive habits. Whether you're striving for productivity, fitness, or mental well-being, Ritus empowers you to cultivate a routine tailored to your goals. With intuitive features, insightful analytics, and a vibrant community, Ritus is your ultimate companion on the journey to self-improvement. 

### App Evaluation

- **Mobile:**
    
    Easy to add new habit to tracker and mark the completion of the task
    
- **Story:**

    User can be more consistent with implementing new habits with ability to track progress.
    
- **Market:**

    People who want to be consistent with building new habits
    
- **Habit:**

    User can check completion for the current day every time they do it, that helps track real progress
    
- **Scope:**

    Create app for adding habits with the frequency of execution, ability to check completion during present day and tracking progress. Additional feathure for future is receiving achivies for good progress
    
## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] User can navigate between different screen by bottom navigation bar
- [X] User can add tracker for new habbit with name and description
- [X] User can specify frequency of execution
- [X] User can check completion within current day
- [X] User can see progress in percent
- [X] User can see list of trackers with name and progress
- [X] User can open specific tracker in separate screen
- [X] User can receive awards for achivements
- [X] User can see list of awards with description
- [X] User can see habit details with cempleted days, name, description and progres
- [X] User can delete tracker


**Optional Nice-to-have Stories**

- [ ] User can receive reminder of habit
- [ ] User can see trackers devided by time of day
- [ ] User can see calender with whole list of habits for specific day
- [X] User can check habit inside calendar screen
- [ ] User can see list of advise about habits
- [X] User can specify days for habit

### 2. Screen Archetypes

**Trackers List Screen**

* User can see list of trackers with name and progress 
* User can open specific tracker in separate screen
* User can see progress in percent

**Tracker Details Screen**

* User can check completion within current day
* User can see progress in percent
* User can see habit details with cempleted days, name, description and progres
* User can delete tracker

**Add New Tracker Screen**

* User can add tracker for new habbit with name and description
* User can specify frequency of execution

**Awards List Screen**

* User can receive awards for achivements
* User can see list of awards with description

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Trackers List
* Add New Tracker
* Awards List

**Flow Navigation** (Screen to Screen)

* Tracker List
    * => Tracker Details
* Add New Tracker
    * => Tracker List
* Tracker Details
    * => Tracker List
* Awards List
    * => None 

## Wireframes

![EPSON219_page-0001](https://github.com/MariiaMohylska/ritus/assets/55410334/bf59f332-f789-46fb-9e32-5348d47b9f37)


## Progress

Navigation between different screen via bottom navigation bar 
[Main Navigtion Schema](https://youtube.com/shorts/eRYMXD7fWJI)

Implemented basic function except Awards
[Basic Features - module 9 homework](https://youtube.com/shorts/kyqrEh0xvn4)

Final demo. For demo purposes some code was a a little bit hardcoded, but returned back after
[Final DEMO](https://youtube.com/shorts/saCcr29UYjw)

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

In this app have been used such APIs:
https://api.unsplash.com/
https://type.fit/api/quotes

