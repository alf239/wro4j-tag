wro4j Tag Library
=================

We use this library in [Gene Expression Atlas](https://github.com/gxa/gxa) in order to be able
to use compressed resources (JS, CSS) not giving up the ability to debug with separate uncompressed 
files.

The library is based on the [wro4j project](http://alexo.github.com/wro4j/) by [Alex Objelean](https://github.com/alexo).

Notes from [Olga Melnichuk](https://github.com/olgamelnichuk):

To cut the long story short, wro4j-tag is a build-time solution for wro4j. All the js/css resources are assembled into bundles and minimized during Maven build; there is a wro4j group config in the WEB-INF dir which says how to assemble the resources. Then, during the run time, the jsp tag reads this config and, depending on the "debug option", substitutes the wro group with the corresponding resource bundle or the set of resources for this bundle.

Wro4j-tag does not use wro4j runtime.

Here is an example of maven config:

```
<plugin>
      <groupId>ro.isdc.wro4j</groupId>
      <artifactId>wro4j-maven-plugin</artifactId>
      <version>${wro4j.version}</version>
      <executions>
           <execution>
                 <phase>prepare-package</phase>
                 <goals>
                      <goal>run</goal>
                  </goals>
            </execution>
      </executions>
      <configuration>
            <wroManagerFactory>uk.ac.ebi.gxa.web.wro4j.HashNamingYUIManagerFactory</wroManagerFactory>
            <cssDestinationFolder>${project.build.directory}/${project.build.finalName}${wro4j.aggregation.css.path}</cssDestinationFolder>
            <jsDestinationFolder>${project.build.directory}/${project.build.finalName}${wro4j.aggregation.js.path}</jsDestinationFolder>
            <contextFolder>${basedir}/src/main/webapp/</contextFolder>
            <minimize>true</minimize>
       </configuration>
</plugin>
```

An example of WEB-INF/wro.xml:

```
<groups xmlns="http://www.isdc.ro/wro"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.isdc.ro/wro wro.xsd">

   <group name="bundle-jquery-flot">
       <js>/scripts/jquery.transform-0.9.0pre.js</js>
       <js>/scripts/jquery.flot-0.6.atlas.js</js>
       <js>/scripts/jquery.flot.headers.js</js>
       <js>/scripts/jquery.flot.boxplot.js</js>
       <js>/scripts/jquery.flot.scroll.js</js>
       <js>/scripts/jquery.flot.selection.js</js>
   </group>
  ....
</groups>
```

And an example of jsp:

```
<html>
<head>
        <wro4j:all name="bundle-jquery-flot"/>
</head>
...
</html>
```

And the most tricky part, the magic debug option. Just add this `wro4j-tag.properties` to your classpath:

```
wro4j.tag.aggregation.path.JS=${wro4j.aggregation.js.path}
wro4j.tag.aggregation.path.CSS=${wro4j.aggregation.css.path}
wro4j.tag.aggregation.name.pattern=@groupName@-[a-f0-9]+\\.@extension@
wro4j.tag.debug=false
```

Notes:

1. Allow Maven to filter `wro4j.aggregation.js.path` and `wro4j.aggregation.css.path` variables for you.
2. `wro4j.tag.aggregation.name.pattern` is a pattern used by the tag to find aggregated resources (bundles). In the current example I use `HashNamingYUIManagerFactory` to add a hash to the bundle name, so that instead of e.g. `bundle-jquery-flot.js` the generated bundle name would be something like `bundle-jquery-flot-e7c9a0fc.js`
