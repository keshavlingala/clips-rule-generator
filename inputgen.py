#!/usr/local/bin/python3.10
import random
# India
# Master
# Woman
# Dev
# No
# 7
# 5
# Java
# n

countries = ["India", "United States", "China", "Germany", "Brazil", "Australia", "Canada", "Russia", "Japan", "South Africa"]
print(random.choice(countries))
edlevels = ["Master", "Undergraduate", "PhD", "NoHigherEd", "Other"]
print(random.choice(edlevels))
genders=['Man','Woman','NonBinary']
print(random.choice(genders))
mainbranches=['Dev','NotDev']
print(random.choice(mainbranches))
accessibilities=['Yes','No']
print(random.choice(accessibilities))
yearscode=random.randint(0,20)
print(yearscode)
yearscodepro=random.randint(0,yearscode)
print(yearscodepro)
skills='APL;Assembly;Bash/Shell;C;C#;C++;Clojure;COBOL;Crystal;Dart;Delphi;Elixir;Erlang;F#;Fortran;Go;Groovy;Haskell;HTML/CSS;Java;JavaScript;Julia;Kotlin;LISP;Lua;MATLAB;OCaml;Objective-C;Perl;PHP;PowerShell;Python;R;Ruby;Rust;SAS;Scala;Solidity;SQL;Swift;TypeScript;VBA;Ansible;Docker;Flow;Homebrew;Kubernetes;npm;Puppet;Terraform;Unity 3D;Yarn;Angular;Angular.js;ASP.NET;ASP.NET Core ;Blazor;Deno;Django;Drupal;Express;FastAPI;Fastify;Flask;Gatsby;jQuery;Laravel;Next.js;Node.js;Nuxt.js;Phoenix;Play Framework;React.js;Ruby on Rails;Svelte;Symfony;Vue.js;AWS;Colocation;DigitalOcean;Firebase;Google Cloud;Heroku;IBM Cloud or Watson;Linode;Managed Hosting;Microsoft Azure;Oracle Cloud Infrastructure;OpenStack;OVH;VMware;Cassandra;Couchbase;CouchDB;Cloud Firestore;DynamoDB;Elasticsearch;IBM DB2;MariaDB;Microsoft SQL Server;MongoDB;MySQL;Oracle;PostgreSQL;Firebase Realtime Database;Redis;SQLite'.split(';')
for i in range(random.randint(1,3)):
    print(random.choice(skills),end=' ')
print()
print('n')