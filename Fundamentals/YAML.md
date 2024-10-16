# YAML (YAML Ain't Markup Language)

### Why do we need YAML?

- **Fact**: There are several programming languages, but only a handful of languages for storing and transferring data.
- Applications need a standard, agreed-upon language/syntax to communicate. Therefore, a **data serialization language** is required.
- **eXtensible Markup Language (XML)**, **JavaScript Object Notation (JSON)**, and **YAML Ain't Markup Language (YAML)** are commonly used data serialization (data representation) languages.
  
The two application components (tiers) of the web app can now communicate successfully using the data serialization language of choice. For example, **JSON** in this case.

### Why YAML and not JSON or XML?

- **XML**:
  ```xml
  <Servers>
      <Server>
          <hostname>APP1</hostname>
          <manufacturer>HP</manufacturer>
          <tier>Backend</tier>
      </Server>
  </Servers>
  ```

- **JSON**:
  ```json
  {
      "Server": [
          {
              "hostname": "APP1",
              "manufacturer": "HP",
              "tier": "Backend"
          }
      ]
  }
  ```

- **YAML**:
  ```yaml
  hostname: APP1
  manufacturer: HP
  tier: Backend
  ```

### Why YAML?

- YAML is a digestible, human-readable serialization language used to create configuration files.
- It is supported by most (if not all) popular programming languages.
- YAML is designed for easier human interaction compared to JSON or XML.
- Widely used in many DevOps tools, including **Kubernetes**, **Ansible**, **Docker**, **Prometheus**, **AWS CloudFormation**, and others.

### YAML - Use Cases

YAML works well in:
- Configuration files
- Log files
- Inter-process messaging
- Cross-language data sharing
- Object persistence
- Debugging of complex data structures

### YAML - Data Structures

YAML uses three basic data structures:
1. **Scalars** (strings, numbers, booleans)
2. **Mappings** (hashes/dictionaries)
3. **Sequences** (arrays/lists)

These structures allow YAML to form a complete data serialization language for any native data structure, with the addition of:
- A simple typing system
- An aliasing mechanism

### YAML - Comments

Comments can be used in YAML and are ignored during processing. They can be placed on separate lines or following data.

```yaml
# this is alice john's info
name: alice john
age: 5
gender: 'female'
height: 3.5
fav_color: "red"
employed: false
birthday: 2017-02-27  # YYYY-MM-DD
```

### YAML - Document Structure

- YAML uses three dashes (`---`) to indicate the start of a document.
- It uses three dots (`...`) to indicate the end of a document.
- Multiple documents can exist in a single YAML stream.

```yaml
---
time:
  actor: Dwayne Johnson
  action: score
...
```

### YAML - Online Tools

- **YAML Validator**: [Online YAML Tools](https://onlineyamltools.com/validate-yaml) – highlights errors in YAML files.
- **YAML Viewer**: [YAML Viewer](https://isonformatter.org/yaml-viewer) – visualize the structure of YAML files.

### YAML - Key/Value Pairs Examples

All of these are valid key/value pairs in YAML:

```yaml
'key with quotations': 'value in quotation'
23: "An integer key with a string value"
'a boolean value': true
key_including_three_spaces: 3
a_null_value: null
```

### YAML - Strings & Quotes

String values can use double quotes, single quotes, or no quotes. However, special characters like `:{}[],&*^%<>+!@` need to be escaped using either single or double quotes.

```yaml
student_name: Alice John
student_name: 'Alice John'
student_name: "Alice John"
```

### YAML - Block Collections: Sequences/Lists/Arrays

A sequence/array/list of items is represented using a dash and space (`-`). YAML also supports square brackets for lists.

```yaml
students:
  - Mohamed Salah
  - Amit Gupta
  - John Smith

# Using square brackets
car_parts: ["tires", "engine", "gas tank"]
car_speeds: [80.0, 50.2, 120.1]
```

### YAML - Nested Structures

You can nest dictionaries and sequences in YAML. Lists can also be nested inside dictionaries, and vice versa.

```yaml
# Sequence of mappings (list of dictionaries)
player_games:
  - name: John Suarez
    games: 10
  - name: Eduardo Lima
    games: 4

# Sequence nested inside a dictionary
player_games:
  name: John Suarez
  games_played: 100
  years_played:
    - 1998
    - 2002
    - 2010

# Nested dictionaries
player_games:
  name: John Suarez
  games_played: 100
  injury_years:
    knee: 1998
    shoulder: 2002
    shin: 2005
```

### YAML - Advanced Features

#### Multi-line Strings

- The `>` symbol replaces new lines in a string scalar with spaces.
- The `|` symbol preserves new lines in folded strings.

```yaml
name: John Smith
accomplishment: >
  John was the president of
  kids' world bank from
  1992 through 2020.

# Preserving lines
name: John Smith
accomplishment: |
  John was the president of
  kids' world bank from
  1992 through 2020.
```

#### Anchors and Aliases

YAML allows you to duplicate content using anchors (`&`) and references (`*`).

```yaml
anchored_content: &anchor_name This is a value that will be referenced again
use_reference: *anchor_name
```

#### Merging with Anchors

You can use anchors to merge entire objects.

```yaml
# Define anchor
- step1: &id001
    instrument: Lasik 2000
    repetition: 1000
    spotSize: 1mm

# Merge with modifications
- step2:
    <<: *id001
    spotSize: 2mm  # Override the value
```

#### Complex Keys

Keys that span multiple lines can be represented using the question mark (`?`).

```yaml
? This is an example of a
  key that has multiple lines
: and this is its value
```

### YAML - Common Editors

YAML files can be saved with `.yaml` or `.yml` extensions. Some well-known YAML editors include:
- **Microsoft Visual Studio (VS)**: [Download VS](https://visualstudio.microsoft.com/downloads/)
- **PyCharm**: [Download PyCharm](https://www.jetbrains.com/pycharm/download/#section=mac)
- **Eclipse IDE**

### Kubernetes YAML Example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-web
  labels:
    role: myrole
spec:
  containers:
    - name: web
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
```
---