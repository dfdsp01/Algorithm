
#import "BinaryTree.h"
#import "BinaryTreeNode.h"

@implementation BinaryTree

/**
 * 生成二叉树
 *
 * @param values 数组
 *
 * @return 二叉树
 */
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values {
    BinaryTreeNode *root = nil;
    for (NSInteger i=0; i<values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [[self class] addTreeNode:root value:value];
    }
    return root;
}

/**
 * 翻转二叉树（非递归）
 *
 * @param rootNode 根节点
 *
 * @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTreeWithoutRecursion:(BinaryTreeNode *)rootNode {
    if (!rootNode) {  return nil; }
    if (!rootNode.leftNode && !rootNode.rightNode) {  return rootNode; }
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        BinaryTreeNode *pLeft = node.leftNode;
        node.leftNode = node.rightNode;
        node.rightNode = pLeft;
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
    return rootNode;
}

/**
 * 翻转二叉树（又叫：二叉树的镜像）
 *
 * @param rootNode 根节点
 *
 * @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {  return nil; }
    if (!rootNode.leftNode && !rootNode.rightNode) {  return rootNode; }
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    return rootNode;
}

#pragma mark - 遍历二叉树

/// 先序遍历
+ (void)treeFirstInformationWithNode:(BinaryTreeNode *)rootNode resultBlock:(void (^)(NSInteger value))block{
    if (block) {
        block(rootNode.value);
    }
    if (rootNode.leftNode) {
        [self treeFirstInformationWithNode:rootNode.leftNode resultBlock:block];
    }
    if (rootNode.rightNode) {
        [self treeFirstInformationWithNode:rootNode.rightNode resultBlock:block];
    }
}

/// 中序遍历
+ (void)treeMiddleInformationWithNode:(BinaryTreeNode *)rootNode resultBlock:(void (^)(NSInteger value))block{
    
    if (rootNode.leftNode) {
        [self treeMiddleInformationWithNode:rootNode.leftNode resultBlock:block];
    }
    if (block) {
        block(rootNode.value);
    }
    if (rootNode.rightNode) {
        [self treeMiddleInformationWithNode:rootNode.rightNode resultBlock:block];
    }
}

/// 后序遍历
+ (void)treeLastInformationWithNode:(BinaryTreeNode *)rootNode resultBlock:(void (^)(NSInteger value))block{
    if (rootNode.leftNode) {
        [self treeLastInformationWithNode:rootNode.leftNode resultBlock:block];
    }
    
    if (rootNode.rightNode) {
        [self treeLastInformationWithNode:rootNode.rightNode resultBlock:block];
    }
    if (block) {
        block(rootNode.value);
    }
}

#pragma mark - Private SEL


+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value {
    //根节点不存在，创建节点
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
        NSLog(@"node:%@", @(value));
    }
    else if (value <= treeNode.value) {
        NSLog(@"to left");
        //值小于根节点，则插入到左子树
        treeNode.leftNode = [[self class] addTreeNode:treeNode.leftNode value:value];
    }
    else {
        NSLog(@"to right");
        //值大于根节点，则插入到右子树
        treeNode.rightNode = [[self class] addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

@end
