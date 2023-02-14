/*
608. Tree Node
https://leetcode.com/problems/tree-node/description/
Amazon/Uber Interview Question

Each node in the tree can be one of three types:
"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write an SQL query to report the type of each node in the tree.

The first time I forgot to do IS NOT NULL.
A NOT NULL p_id is a root.
*/

SELECT id, 
CASE 
WHEN p_id IS NULL THEN 'Root'
WHEN id NOT IN (SELECT p_id FROM tree WHERE p_id is NOT NULL) THEN 'Leaf'
ELSE 'Inner' 
END as type
FROM tree
