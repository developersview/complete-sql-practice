drop table if exists tricky1;
create table tricky1 ( id1 INT );
insert into tricky1 (id1) values (1), (1), (2), (null), (null);


drop table if exists tricky2;
create table tricky2 ( id2 INT );
insert into tricky2 (id2) values (1), (2), (2), (3), (null);

select * from tricky1;
select * from tricky2;

-- left join
select * from tricky1 t1 left join tricky2 t2 on t1.id1 = t2.id2; 

-- right join
select * from tricky1 t1 right join tricky2 t2 on t1.id1 = t2.id2; 

-- inner join
select * from tricky1 t1 inner join tricky2 t2 on t1.id1 = t2.id2; 

-- full join
select * from tricky1 t1 full join tricky2 t2 on t1.id1 = t2.id2; 


/* 
 * Let's analyze the outputs **step-by-step** for each type of join based on the data in `tricky1` and `tricky2`.
---

### ✅ Step 1: Input Tables

#### `tricky1` (5 rows)

| id1  |
| ---- |
| 1    |
| 1    |
| 2    |
| NULL |
| NULL |

#### `tricky2` (5 rows)

| id2  |
| ---- |
| 1    |
| 2    |
| 2    |
| 3    |
| NULL |

---

### ✅ Step 2: Join Condition

All joins use:

```sql
ON t1.id1 = t2.id2
```

💡 **Important Notes**:

* `NULL = NULL` is **false**, so NULLs will **not match** each other.
* Duplicates in either table can create **combinatorial matches**.

---

## 🔷 1. LEFT JOIN (t1 LEFT JOIN t2)

```sql
SELECT * FROM tricky1 t1 LEFT JOIN tricky2 t2 ON t1.id1 = t2.id2;
```

For each row in `tricky1`, find matching rows in `tricky2` or return NULLs if no match.

Let’s match each `id1`:

* `1` (appears twice in `tricky1`) matches `1` (once in `tricky2`) → 2 × 1 = **2 rows**
* `2` (once in `tricky1`) matches `2` (twice in `tricky2`) → 1 × 2 = **2 rows**
* `NULL` (twice in `tricky1`) matches nothing → 2 × 1 = **2 rows with NULLs from t2**

✅ **Total LEFT JOIN output = 2 + 2 + 2 = 6 rows**

---

## 🔷 2. RIGHT JOIN (t1 RIGHT JOIN t2)

```sql
SELECT * FROM tricky1 t1 RIGHT JOIN tricky2 t2 ON t1.id1 = t2.id2;
```

For each row in `tricky2`, find matching rows in `tricky1` or return NULLs if no match.

Match each `id2`:

* `1` (once in `tricky2`) matches two `1`s in `tricky1` → 1 × 2 = **2 rows**
* `2` (twice in `tricky2`) matches one `2` in `tricky1` → 2 × 1 = **2 rows**
* `3` matches nothing in `tricky1` → 1 row with NULLs from t1
* `NULL` matches nothing → 1 row with NULLs from t1

✅ **Total RIGHT JOIN output = 2 + 2 + 1 + 1 = 6 rows**

---

## 🔷 3. INNER JOIN

```sql
SELECT * FROM tricky1 t1 INNER JOIN tricky2 t2 ON t1.id1 = t2.id2;
```

Only matching rows on both sides are returned.

Match possibilities:

* `1` (2 rows in t1) × `1` (1 row in t2) → **2**
* `2` (1 row in t1) × `2` (2 rows in t2) → **2**

✅ **Total INNER JOIN output = 2 + 2 = 4 rows**

---

## 🔷 4. FULL OUTER JOIN

```sql
SELECT * FROM tricky1 t1 FULL JOIN tricky2 t2 ON t1.id1 = t2.id2;
```

All matches + non-matching rows from both tables.

Let’s count:

* Matched:

  * `1` → 2 rows
  * `2` → 2 rows
    → **4 rows**

* Unmatched from `tricky1`: `NULL`, `NULL` → **2 rows**

* Unmatched from `tricky2`: `3`, `NULL` → **2 rows**

✅ **Total FULL OUTER JOIN output = 4 (matched) + 2 + 2 = 8 rows**

---

## ✅ Final Summary

| Join Type  | Output Rows | Why                                          |
| ---------- | ----------- | -------------------------------------------- |
| LEFT JOIN  | 6           | All `t1` rows + matching or NULLs from `t2`  |
| RIGHT JOIN | 6           | All `t2` rows + matching or NULLs from `t1`  |
| INNER JOIN | 4           | Only exact matches (1=1, 2=2)                |
| FULL JOIN  | 8           | All matched rows + unmatched from both sides |

Let me know if you want a visual representation or a real SQL test output.
 */