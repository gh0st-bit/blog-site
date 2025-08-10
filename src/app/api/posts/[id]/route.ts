import { NextResponse } from 'next/server';
import { mockDb } from '@/lib/mockdb';
import type { MongoClient, ObjectId as MongoObjectId } from 'mongodb';

// Try to import MongoDB, fall back to mock if not available
let clientPromise: Promise<MongoClient> | null = null;
let ObjectId: typeof MongoObjectId | null = null;
try {
  const { default: mongoClientPromise } = await import('@/lib/mongodb');
  const { ObjectId: MongoObjectIdClass } = await import('mongodb');
  clientPromise = mongoClientPromise;
  ObjectId = MongoObjectIdClass;
} catch {
  console.log('MongoDB not available, using mock database');
}

export async function GET(request: Request, { params }: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await params;
    
    // Try MongoDB first, fall back to mock
    if (clientPromise && process.env.MONGODB_URI && ObjectId) {
      try {
        const client = await clientPromise;
        const db = client.db();
        const post = await db.collection('posts').findOne({ _id: new ObjectId(id) });
        return NextResponse.json(post);
      } catch (mongoError) {
        console.log('MongoDB connection failed, using mock database:', mongoError);
      }
    }
    
    // Use mock database as fallback
    const post = await mockDb.findById(id);
    return NextResponse.json(post);
  } catch (error) {
    console.error('Error fetching post:', error);
    return NextResponse.json({ error: 'Failed to fetch post' }, { status: 500 });
  }
}

export async function PUT(request: Request, { params }: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await params;
    const data = await request.json();
    
    // Try MongoDB first, fall back to mock
    if (clientPromise && process.env.MONGODB_URI && ObjectId) {
      try {
        const client = await clientPromise;
        const db = client.db();
        const result = await db.collection('posts').updateOne({ _id: new ObjectId(id) }, { $set: data });
        return NextResponse.json(result);
      } catch (mongoError) {
        console.log('MongoDB connection failed, using mock database:', mongoError);
      }
    }
    
    // Use mock database as fallback
    const result = await mockDb.updateById(id, data);
    return NextResponse.json(result);
  } catch (error) {
    console.error('Error updating post:', error);
    return NextResponse.json({ error: 'Failed to update post' }, { status: 500 });
  }
}

export async function DELETE(request: Request, { params }: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await params;
    
    // Try MongoDB first, fall back to mock
    if (clientPromise && process.env.MONGODB_URI && ObjectId) {
      try {
        const client = await clientPromise;
        const db = client.db();
        const result = await db.collection('posts').deleteOne({ _id: new ObjectId(id) });
        return NextResponse.json(result);
      } catch (mongoError) {
        console.log('MongoDB connection failed, using mock database:', mongoError);
      }
    }
    
    // Use mock database as fallback
    const result = await mockDb.deleteById(id);
    return NextResponse.json(result);
  } catch (error) {
    console.error('Error deleting post:', error);
    return NextResponse.json({ error: 'Failed to delete post' }, { status: 500 });
  }
}
