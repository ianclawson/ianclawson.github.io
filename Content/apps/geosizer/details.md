---
itemAppSection: geosizer
itemAppSubsection: details

date: 2022-02-05 11:33
description: An app that allows you highlight the shape of a given geographic feature (such as a country, state, or province), and see what that shape looks like juxtaposed with a different part of the world.

published: true
crumbs: Home, GeoSizer
---

# Details and Background

I've wanted this app for so long, but I've never gotten around to it until now.

In another life I might have been a Geospacial Data Analyst. Back in college I took some Geography and Cartography courses and was heading down a path to graduate with a GIS Certification. Since then I changed majors into Computer Science, but my love for those things has always remained.

One of the first things you learn about global maps is _projections_; Simply by the nature of representing spacial 3D data in a 2D format, flattening a sphere/ellipsoid onto a flat surface will inevitably result in distorion. So you need to project your map in a way that preserves the data that is most important to you, while sacrificing some other data in the process.

You might be familiar with the Mercator Projection of the World Map — in western countries it's the map seen most frequently in school classrooms. While it's incredibly useful for travelers, sailors, and aviators due to it's ability to represent constant, true compass direction, the Mercator Projection does not excel in representing a geographic feature's true shape and size, especially when you approach the top and bottom of the map.

Because of this, it can be common to not know the true size/shape of one country compared to another.

So why shouldn't there be some tool that allows use to compare two countries' shapes and sizes easily?

# Geographic Juxtapositioning Made Easy

GeoSizer aims to be the easiest and most accessible way to compare the actual size and shape of one geographic feature (a country, state, province, etc.) to another. 

It's as simple as 3 steps:
1. Select a geographic feature by either tapping on the map, or by using the "GO TO" button
2. Once you've selected a feature, press a single button to take that shape and begin moving it around the world
3. When you've decided where to place it, press another button to leave the shape there, and view the feature from new angles

And near-instantly you've got the information you need right in front of you.

# How the Magic is Made

Another reason I made GeoSizer is because it sounded like a fun enginnering challenge.

In order to draw geographic features (countries, states, provinces, etc.) onto a ellipsoid map of the Earth, we need to use a GCS, or Geographic Coordinate System (such as Latitude and Longitude), so that we can specify where these points of our feature (or "cutout") should be drawn. This is the globe's coordinate system.

Because of the nature of the Latitude/Longitude GCS, we cannot perform simple mathematical translation of our cutout's points to another area on the globe without incurring some shape and size distortion. To overcome this, during the juxtaposition step, GeoSizer converts the cutout shape's points from the globe's coordinate system into a different coordinate system — the flat coordinate system of the screen of your device — and preserves the points in that form until it's time to convert the cutout's points back into the globe's coordinate system.

When we convert to and from the screen's coordinate system and the globe's coordinate system, we preserve to keep the relationship (the distance and postion between them) EXACT; otherwise our cutout's shape or size will become distorted from its original form when we bring the cutout back into the globe's coordinate system.

By preserving that relation between coordinate systems when moving the feature and ensuring the relationship's integrity when the feature is placed, the shape and size of the feature remain intact. 

Though this app should not be used to measure the distance/length/area of countries to any unit of measurement, the shape and size preservation when moving the feature is true and accurate.
